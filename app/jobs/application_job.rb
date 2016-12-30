class ApplicationJob < ActiveJob::Base
	def normalize_price(price)
		price = price.to_s
		price.strip!
		price.gsub!(/(?<=\d),(?=\d)/, '.')		# 10,00 € => 10.00 €
		price.gsub!(/ €/, '€')								# 10.00 € => 10.00€
		price.gsub!(/\/(?=\d)/, '/ ')					# 10€/20€ => 10€/ 20€
		price.gsub!(/€\//, '€ /')							# 10€/ 20€ => 10€ / 20€

		return price
	end

	def normalize_time(time)
		time = time.to_s
		time.strip!
		time.gsub!(/(?<=\d).(?=\d)/, ':')			# 10.00-11.00 => 10:00-11:00
		time.gsub!(/(?<=\d)-(?=\d)/, ' - ')		# 10:00-11:00 => 10:00 - 11:00

		return time
	end

	def normalize_name(name)
		name = name.to_s
		name.strip!
		name.gsub!(/ ,/, ', ')								# G ,L ,Veg => G, L, Veg

		return name
	end
	
	def get_tag_from_name(name)
		case name.to_s.downcase
		when /kasvi/, /vege/, /salaatti/, /salad/
			"vegetarian"
		when /kevyt/, /keitto/, /light/, /soup/
			"light"
		when /grill/, /erikois/, /portion/, /pitsa/, /pizza/, /bizza/
			"grill"
		when /herkuttelija/, /herkku/, /special/
			"special"
		when /jälki/, /jälkkäri/, /dessert/
			"dessert"
		when /aamu/, /aamiainen/, /breakfast/, /morning/
			"breakfast"
		end
	end
end
