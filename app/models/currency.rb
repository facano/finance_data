# frozen_string_literal: true

class Currency < ApplicationRecord
  enum currency_type: %i[dolar uf]
  default_scope -> { order(date: :asc) }

  class << self
    def between(date1, date2, currency, formated = false)
      case currency
      when :dolar
        data = Integration::SBIF::UF.between(date1, date2)
      when :uf
        data = Integration::SBIF::Dolar.between(date1, date2)
      end
      if data && formated
        return format_data(data)
      else
        return data
      end
    end

    def set_until(date, currency)
      until_date = date
      last_currency = send(currency).last
      if last_currency
        if last_currency.date < date
          # Fill between dates
          case currency
          when :dolar
            results =  Integration::SBIF::Dolar.between(last_currency.date, date)
          when :uf
            results =  Integration::SBIF::UF.between(last_currency.date, date)
          end
          set_data(results, currency)
          return results
        end
      else # Empty db
        case currency
        when :dolar
          results =  Integration::SBIF::Dolar.before_month(date)
          results += Integration::SBIF::Dolar.by_month(date)
        when :uf
          results =  Integration::SBIF::UF.before_month(date)
          results += Integration::SBIF::UF.by_month(date)
        end
        set_data(results, currency)
        return results
      end
    end

    def set_data(results, currency)
      results.each do |result|
        next if send(currency).find_by(date: result['Fecha'])
        Currency.create(currency_type: currency,
                        date: result['Fecha'],
                        clp_value: result['Valor'].delete('.').tr(',', '.').to_f)
      end
    end

    def format_data(data)
      Hash[*data.map { |data| [data['Fecha'], data['Valor'].delete('.').tr(',', '.').to_f] }.flatten]
    end
  end
end
