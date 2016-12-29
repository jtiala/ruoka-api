require 'open-uri'
require 'json'

class ImportAmicaJob < ApplicationJob
	queue_as :default

	@@languages = ['fi', 'en']
	@@date_range = ((Date.today - 10)..(Date.today + 10)) # temporary solution
	@@url = 'http://www.amica.fi/modules/json/json/Index?costNumber=%s&language=%s&firstDay=%s'

	def perform(*args)
		dates = get_dates(@@date_range)
		restaurants = Restaurant.where(chain: 'Amica')

		@@languages.each do |language|
			dates.each do |date|
				restaurants.each do |restaurant|
					unless restaurant.download_identifier.empty?
						menu_data = get_menu(restaurant.download_identifier, language, date.strftime("%Y-%-m-%-d"))
						unless menu_data.empty?
							if menu_data.key?('RestaurantUrl')
								restaurant.url = menu_data['RestaurantUrl'].to_s
								restaurant.save
							end

							i = 0
							if menu_data.key?('MenusForDays') && menu_data['MenusForDays'].respond_to?('each')
								menu_data['MenusForDays'].each do |daily_menu_data|
									i = i+1

									if daily_menu_data.key?('Date')
										begin
											menu_date = Date.parse(daily_menu_data['Date'])
										rescue ArgumentError => e
											# Date is invalid, do nothing
										else
											menu = Menu.where(restaurant: restaurant, date: menu_date, language: language).first_or_initialize
											menu.lunch_time = daily_menu_data['LunchTime'].to_s if daily_menu_data.key?('LunchTime')
											menu.save

											menu_items = []

											if daily_menu_data.key?('SetMenus') && daily_menu_data['SetMenus'].respond_to?('each')
												count = 0
												daily_menu_data['SetMenus'].each do |set_menu_data|
													if set_menu_data.key?('Name') && ! set_menu_data['Name'].empty?
														menu_item = {name: set_menu_data['Name'].to_s}

														if set_menu_data.key?('Price')
															menu_item[:price] = set_menu_data['Price'].to_s
														else
															menu_item[:price] = nil
														end

														if set_menu_data.key?('SortOrder')
															menu_item[:sort_order] = set_menu_data['SortOrder'].to_i
														else
															menu_item[:sort_order] = 0
														end

														menu_item[:components] = []
														if set_menu_data.key?('Components') && set_menu_data['Components'].respond_to?('each')
															set_menu_data['Components'].each do |component_data|
																unless component_data.empty?
																	menu_item[:components].push({name: component_data.to_s})
																end
															end
														end

														menu_item[:count] = count
														count = count + 1

														menu_items.push(menu_item)
													end
												end
											end

											menu_items.sort! { |a, b| [a[:sort_order], a[:count]] <=> [b[:sort_order], b[:count]] }
											weight = 0
											menu_items.each do |menu_item|
												menu_item[:weight] = weight
												menu_item.delete(:sort_order)
												menu_item.delete(:count)
												weight = weight + 1
											end

											valid_items = []
											menu_items.each do |menu_item|
												unless menu_item.empty?
													item = MenuItem.where(menu: menu, name: menu_item[:name], price: menu_item[:price], components: menu_item[:components], weight: menu_item[:weight]).first_or_create
													valid_items.push(item.id)
												end
											end

											MenuItem.where.not(id: valid_items).where(menu: menu).destroy_all
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	# Amica menus need to be downloaded one week a time starting from monday
	# This method gets all the mondays in a given date range
	def get_dates(date_range)
		week_start_dates = []

		date_range.each do |date|
			if date.is_a? Date 
				week_start = date.beginning_of_week
				unless week_start_dates.include? week_start
					week_start_dates.push(week_start)
				end
			end
		end

		week_start_dates
	end

	def get_menu(restaurant, language, date)
		download_url = @@url % [restaurant, language, date]

		attempt_count = 0
		max_attempts  = 3
		menu = nil

		begin
			attempt_count += 1
			content = open(download_url).read
		rescue OpenURI::HTTPError => e
			# it's 404, etc. (do nothing)
		rescue SocketError, Net::ReadTimeout => e
			# server can't be reached or doesn't send any respones
			sleep 3
			retry if attempt_count < max_attempts
		else
			menu = JSON.parse(content)
		end

		menu
	end
end
