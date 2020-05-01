class CreateMobiles < ActiveRecord::Migration[6.0]
  def change
    create_table :mobiles do |t|
      t.integer :mobile_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
