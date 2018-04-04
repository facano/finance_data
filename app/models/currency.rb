class Currency < ApplicationRecord
  enum currency_type: [:DOLAR, :UF]
  
end
