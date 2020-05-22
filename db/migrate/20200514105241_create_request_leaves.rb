class CreateRequestLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :request_leaves do |t|

    	t.references :user
    	t.string :subject 
    	t.string :message 
    	t.datetime :date_from 
    	t.datetime :date_to 
    	t.string :leave_count 
    	t.boolean :status 

      t.timestamps
    end
  end
end
