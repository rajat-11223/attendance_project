class AddFieldToRequestLeave < ActiveRecord::Migration[6.0]
  def change

  	remove_column :request_leaves, :status

      add_column :request_leaves, :status, :integer
  end
end
