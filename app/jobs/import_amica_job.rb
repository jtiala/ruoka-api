class ImportAmicaJob < ApplicationJob
	queue_as :default

	def perform(*args)
		# Import logic here
	end
end
