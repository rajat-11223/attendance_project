class CreateDailyAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_attendances do |t|


        t.references :user
        t.references :master_attendance_status
    	t.datetime :punch_in
    	t.datetime :punch_out
    	

      t.timestamps
    end
  end
end
