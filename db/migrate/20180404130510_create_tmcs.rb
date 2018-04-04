class CreateTmcs < ActiveRecord::Migration[5.1]
  def change
    create_table :tmcs do |t|
      t.integer :tmc_type
      t.date :date
      t.float :clp_value
      t.string :title
      t.string :subtitle

      t.timestamps
    end
  end
end
