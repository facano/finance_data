# frozen_string_literal: true

module Integration
  module SBIF
    class Base
      API_KEY = ENV['SBIF_KEY']
      API_BASE_URL = 'http://api.sbif.cl/api-sbifv3/recursos_api'

      class << self
        def resource_name
          name.demodulize.downcase
        end

        def resource_key_result
          "#{resource_name.upcase}s"
        end

        def by_year(date)
          resource "#{resource_name}/#{date.year}"
        end

        def by_month(date)
          resource "#{resource_name}/#{date.year}/#{format('%02d', date.month)}"
        end

        def by_day(date)
          resource "#{resource_name}/#{date.year}/#{format('%02d', date.month)}/dias/#{format('%02d', date.day)}"
        end

        def between(date1, date2)
          resource "#{resource_name}/periodo/#{date1.year}/#{date1.month}/#{date2.year}/#{date2.month}"
        end

        ## Before a date
        def before_year(date)
          resource "#{resource_name}/anteriores/#{date.year}"
        end

        def before_month(date)
          resource "#{resource_name}/anteriores/#{date.year}/#{format('%02d', date.month)}"
        end

        ## After a date
        def after_year(date)
          resource "#{resource_name}/posteriores/#{date.year}"
        end

        def after_month(date)
          resource "#{resource_name}/posteriores/#{date.year}/#{format('%02d', date.month)}"
        end

        private

        def resource(url_resource)
          result = RestClient.get "#{API_BASE_URL}/#{url_resource}?apikey=#{API_KEY}&formato=json"
          if result.code == 200
            json_result = JSON.parse(result.body)
            return json_result[resource_key_result]
          else
            raise ArgumentError, 'Invalid response'
            return nil
         end
        rescue Errno::ECONNREFUSED
          Rails.logger.error('Error trying to connect to the SBIF API')
          return nil
        rescue RestClient::NotFound
          Rails.logger.error('Contents not found in SBIF API')
          return nil
        rescue Excepcion => e
          Rails.logger.error('Something wrong happens')
          Rails.logger.error(e)
          return nil
        end
      end
    end
  end
end
