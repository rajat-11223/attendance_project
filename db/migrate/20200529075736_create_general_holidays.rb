class CreateGeneralHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :general_holidays do |t|
      t.datetime :date
      t.string :occasion
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
