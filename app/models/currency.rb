class Currency < ApplicationRecord
  enum currency_type: [:dolar, :uf]
  default_scope -> { order(date: :asc) }

  class << self
    def set_until date, currency
      until_date = date
      last_currency = self.send(currency).last
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
      else #empty db
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
        unless self.send(currency).find_by(date: result["Fecha"])
          Currency.create({
            currency_type: currency,
            date: result["Fecha"],
            clp_value: result["Valor"].gsub(".","").gsub(",", ".").to_f
          })
        end
      end
    end
  end
end
