every 3.hours do
	runner "ImportAmicaJob.perform_later"
end

every 1.day, :at => '4 am' do
	runner "CleanDatabaseJob.perform_later"
end
