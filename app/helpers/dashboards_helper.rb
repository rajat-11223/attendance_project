module DashboardsHelper


def avg_of_times(array_of_time)
  size = array_of_time.size
  avg_minutes = array_of_time.map do |x|
    hour, minute = x.split(':')
    total_minutes = hour.to_i * 60 + minute.to_i
  end.inject(:+)/size
  "#{avg_minutes/60}:#{avg_minutes%60}"
end


	
end
