every 3.hours do
	start_date = Date.today.beginning_of_week
	end_date = start_date + 14
	
	runner "ImportAmicaJob.perform_later('#{start_date.to_s}', '#{end_date.to_s}')"
end
