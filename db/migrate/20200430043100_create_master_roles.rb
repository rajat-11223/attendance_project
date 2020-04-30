class CreateMasterRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :master_roles do |t|
    	t.string :role_name

      t.timestamps
    end
  end
end
