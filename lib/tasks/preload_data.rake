# encoding: utf-8
# frozen_string_literal: true

desc 'Preload data from SBIF'
task :preload_data, :environment do
  today = Time.zone.now
  Currency.set_until today, :dolar
  Currency.set_until today, :uf
end
