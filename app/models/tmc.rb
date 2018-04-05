# frozen_string_literal: true

class TMC < ApplicationRecord
  class << self
    def between(date1, date2, formated = false)
      data = Integration::SBIF::TMC.between(date1, date2)
      if data && formated
        return format_data(data)
      else
        return data
      end
    end

    def format_data(data)
      formated_data = {}
      data.each do |d|
        formated_data[d['Tipo']] ||= {}
        formated_data[d['Tipo']][:label] ||= [d['Titulo'].presence, d['SubTitulo'].presence].join(' - ')
        formated_data[d['Tipo']][:data] ||= []
        formated_data[d['Tipo']][:data] <<  [d['Fecha'], d['Valor']]
      end
      formated_data.map { |k, v| { name: v[:label], data: v[:data], type: k } }
    end
  end
end
