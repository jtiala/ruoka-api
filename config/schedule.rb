require 'active_support/core_ext/date'

every 3.hours do
	start_date = Date.today.beginning_of_week
	end_date = start_date + 14
	clean_older_than = (Date.today - 30).beginning_of_week
	
	runner "ImportAmicaJob.perform_later('" + start_date.to_s + "', '" + end_date.to_s + "')"
	runner "CleanDatabaseJob.perform_later('" + clean_older_than.to_s + "')"
end
