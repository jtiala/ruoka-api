class CleanDatabaseJob < ApplicationJob
	queue_as :default

	def perform(clean_older_than = nil)
		if clean_older_than.nil?
			date = (Date.today - 30).beginning_of_week
		else
			date = Date.parse(clean_older_than)
		end

		Menu.where("date < ?", date).destroy_all
	end
end
