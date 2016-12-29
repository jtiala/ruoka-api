class CleanDatabaseJob < ApplicationJob
	queue_as :default

	def perform(older_than)
		date = Date.parse(older_than)

		Menu.where("date < ?", date).destroy_all
	end
end
