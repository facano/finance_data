module MainHelper
	def data_statistic data
		values = data.values.map(&:to_f)
		min = values.min
		max = values.max
		avg = values.sum/values.count

		[min, max, avg]
	end

  def tmc_stats tmcs
    tmcs.map { |tmc| {name: tmc[:name], max: tmc[:data].map(&:last).max} }
  end
end
