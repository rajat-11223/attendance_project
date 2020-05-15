class Users::CustomController < ApplicationController
#before_action :authenticate_user!, except: %i[index	show]	
before_action :authenticate_user!
 layout "dashboard"

def admindashboard



end

def attendance

@all_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day )

end


def punch_attendance

@attendance = DailyAttendance.find_or_initialize_by(user_id: current_user.id, created_at: Date.today.all_day )
respond_to do |format|
      
        
if params[:punch_in].present?

  @attendance.punch_in = DateTime.now.to_s(:time) 
  @attendance.user_id = current_user.id  
  @attendance.master_attendance_status_id = 1 

  @attendance.save
  format.html { redirect_to attendance_path, notice: 'Hey '+ current_user.name.capitalize+'! Your punch has been captured. You are now PUNCHED IN. ' }
  #format.json { render :show, status: :created, location: @post_review }

end	

if params[:punch_out].present?

  @attendance.punch_out = DateTime.now.to_s(:time) 
  @attendance.user_id = current_user.id  
  @attendance.master_attendance_status_id = 1 

  @attendance.save
  format.html { redirect_to attendance_path, notice: 'Hey '+ current_user.name.capitalize+'! Your punch has been captured. You are now PUNCHED OUT. ' }

end	

end
end


def request_leave

	@request_leave = RequestLeave.new

end

def apply_leave


end	


def employes


end	

end

