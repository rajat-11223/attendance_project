class CreateRequestLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :request_leaves do |t|

    	t.references :user
    	t.string :subject 
    	t.string :message 
    	t.boolean :status 

      t.timestamps
    end
  end
end
