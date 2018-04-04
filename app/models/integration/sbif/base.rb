module Integration
  module SBIF
    class Base
      API_KEY = ENV['SBIF_KEY']
      API_BASE_URL = "http://api.sbif.cl/api-sbifv3/recursos_api"

      class << self
        def resource_name
          self.name.demodulize.downcase
        end

        def by_year date
          resource "#{resource_name}/#{date.year}"
        end 

        def by_month date
          resource "#{resource_name}/#{date.year}/#{date.month}"
        end 

        def by_day date
          resource "#{resource_name}/#{date.year}/#{date.month}/dias/#{date.day}"
        end 

        def between date1, date2
          resource "#{resource_name}/periodo/#{date1.year}/#{date1.month}/#{date2.year}/#{date2.month}"
        end 


        private
        def resource url_resource
          result = RestClient.get "#{API_BASE_URL}/#{url_resource}?apikey=#{API_KEY}&formato=json"
           if result.code == 200
            return JSON.parse(result.body)
          else
            raise ArgumentError.new("Invalid response")
          end
        end
      end
    end
  end
end