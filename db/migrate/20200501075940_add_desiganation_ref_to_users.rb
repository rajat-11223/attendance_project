class AddDesiganationRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :designation, null: true, foreign_key: true
    add_reference :users, :department, null: true, foreign_key: true
  end
end
