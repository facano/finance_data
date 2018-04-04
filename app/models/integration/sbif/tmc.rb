module Integration
  module SBIF
    class TMC < Base 
      class << self
         def by_day date
          raise "Invalid Method for this indicator"
        end 
      end
    end
  end
end