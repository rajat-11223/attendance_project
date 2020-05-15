class Users::CustomController < ApplicationController

#before_action :authenticate_user!, except: %i[index	show]	
before_action :set_user, only: [ :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]
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






	# Action to show Admin and User Dashboard
	def dashboard

	@user_role = UserRole.find_by(:user_id => current_user.id)
	@users = User.all.where.not(id: current_user.id).limit(2)

	end

	def employees
	@users = User.all.where.not(id: current_user.id)
	end


	# admin edit the employees info
	def admin_edit_user
	@designation = Designation.all
	@department = Department.all
	@user = User.find(params[:id])
	@user_role = UserRole.find_by(:user_id => current_user.id)
	end

	# Admin Update the employees info
	def admin_update_user
	# byebug
	end


	# Admin create new user
	def admin_create_user
	# byebug
	end




	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  @currentuser = User.find(current_user.id)
	end
end
