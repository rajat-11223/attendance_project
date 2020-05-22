class Users::CustomController < ApplicationController
include DashboardsHelper

#before_action :authenticate_user!, except: %i[index	show]	
before_action :set_user, only: [ :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]
 layout "dashboard"

def admindashboard



end

def attendance

@all_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day )
@show_attendance = DailyAttendance.where(user_id: current_user.id, :created_at => Time.now.beginning_of_month..Time.now.end_of_month) 

 @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

 @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

#byebug
#@a =  ['18:35', '19:07', '23:09']
@avrg = avg_of_times(@a)
@leaves_taken = RequestLeave.where(status: 1, user_id: current_user.id).sum(:leave_count)
@applied_leaves = RequestLeave.where(status: 0, user_id: current_user.id).sum(:leave_count)
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
	@all_leaves = RequestLeave.where(user_id: current_user.id)

end

def apply_leave
#2020-05-26
#puts params[:date_to].to_date
#puts params[:date_from].to_date
#puts (params[:date_to].to_date - params[:date_from].to_date).to_i

@daterange = params[:dated_from].split()
@count_leave = params[:leave_count] == 1 ? 1 : (@daterange[2].to_date - @daterange[0].to_date).to_i + 1

#byebug


@submit_leave = RequestLeave.new(user_id: current_user.id, subject: params[:subject], message: params[:message], date_from: @daterange[0], date_to: @daterange[2], leave_count: @count_leave)
	respond_to do |format|
		if @submit_leave.save
		format.html { redirect_to request_leave_path, notice: 'Leave applied successfully' }
		end
	end
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
