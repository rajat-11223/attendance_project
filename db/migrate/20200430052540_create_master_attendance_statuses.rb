class CreateMasterAttendanceStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :master_attendance_statuses do |t|

    	t.string :status

      t.timestamps
    end
  end
end
