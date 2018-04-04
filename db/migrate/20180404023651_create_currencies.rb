class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.date :date
      t.float :clp_value
      t.integer :currency_type

      t.timestamps
    end
  end
end
