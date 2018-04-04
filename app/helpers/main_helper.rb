module MainHelper
	def data_statistic data
		values = data.values.map(&:to_f)
		min = values.min
		max = values.max
		avg = values.sum/values.count

		[min, max, avg]
	end
end
