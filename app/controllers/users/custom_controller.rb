class Users::CustomController < ApplicationController
include DashboardsHelper

include CustomHelper
#before_action :authenticate_user!, except: %i[index	show]	
before_action :set_user, only: [ :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]
 layout "dashboard"

def admindashboard



end


def add_new_holiday

@add_new_holiday  = GeneralHoliday.create(date: params[:holiday_date], occasion: params[:occasion_name])

respond_to do |format|
format.html {redirect_to root_url, notice: 'New Holiday added successfully.'}

end

end	

def monthly_attendance

#puts params[:month]


@show_attendance = DailyAttendance.where("MONTH(created_at) = ? and user_id = ?", params[:month].to_i, current_user.id)

 @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

 @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

@avrg = @a.present? ? avg_of_times(@a) : 0 
respond_to do |format|
format.js {render 'attendance_filter'}

end

end	


def update_apply_leave


@update_leave = RequestLeave.find(params[:leave_id])

if params[:dated_from].present?
@daterange = params[:dated_from].split()
@count_leave = params[:leave_count] == 1 ? 1 : (@daterange[2].to_date - @daterange[0].to_date).to_i + 1
@update_leave.date_from = @daterange[0]
@update_leave.date_to = @daterange[2]
@update_leave.leave_count = @count_leave
end

@update_leave.subject = params[:subject]
@update_leave.message = params[:message]
#@update_leave.save
#@submit_leave = RequestLeave.new(user_id: current_user.id, subject: params[:subject], message: params[:message], date_from: @daterange[0], date_to: @daterange[2], leave_count: @count_leave)
	respond_to do |format|
		if @update_leave.save
		format.js {render 'edit_reply_popup'}
		end
	end


end

def remove_apply_leave

if params[:id].present?

@remove_leave = RequestLeave.find(params[:id])	
@remove_leave.delete
respond_to do |format|
		
		format.html { redirect_to request_leave_path, notice: 'Leave deleted successfully' }
		end
	
end	
end
def edit_apply_leave

if params[:lid].present? && params[:uid].present?
@edit_request_leave = RequestLeave.find(params[:lid]) 
respond_to do |format|

format.js {render 'edit_reply_popup'}


end
end	
end

def edit_current_user

	@saveuser = User.find(current_user.id)
	

respond_to do |format|

if @saveuser.present?
   @saveuser.first_name = params[:fname]
   @saveuser.last_name = params[:lname]
   @saveuser.date_of_birth = params[:date_birth]
   @saveuser.facebook = params[:facebook]
   @saveuser.instagram = params[:instagram]
   @saveuser.gender = params[:gender]
 @saveuser.save
	if params[:user_images][:avatar].present?
		# @saveuser.user_images.image_url = params[:image_url]
		# #@saveuser.user_images.is_profie_active = true
		# @saveuser.user_images.save
		@profileimage = UserImage.new
	    @profileimage.user_id = current_user.id
		@profileimage.avatar = params[:user_images][:avatar]
		@profileimage.save!
	end
end
format.html { redirect_to user_profile_path, notice: 'Hey '+ @saveuser.first_name.capitalize+'! profile updated successfully. ' }

   end		

end


def attendance

#@all_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day )
@show_attendance = DailyAttendance.where(user_id: current_user.id, :created_at => Time.now.beginning_of_month..Time.now.end_of_month) 

 @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

 @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

#@cal_time = @a.present? ? @a : 
#byebug
#@a =  ['18:35', '19:07', '23:09']

@avrg = @a.present? ? avg_of_times(@a) : 0 
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
  format.html { redirect_to attendance_path, notice: 'Hey '+ current_user.first_name.capitalize+'! Your punch has been captured. You are now PUNCHED IN. ' }
  #format.json { render :show, status: :created, location: @post_review }

end	

if params[:punch_out].present?

  @attendance.punch_out = DateTime.now.to_s(:time) 
  @attendance.user_id = current_user.id  
  @attendance.master_attendance_status_id = 1 

  @attendance.save
  format.html { redirect_to attendance_path, notice: 'Hey '+ current_user.first_name.capitalize+'! Your punch has been captured. You are now PUNCHED OUT. ' }

end	

end
end


def request_leave

	@request_leave = RequestLeave.new
	@all_leaves = RequestLeave.where(user_id: current_user.id)
	@employe_leaves = RequestLeave.where(user: current_user.id,status: true).sum(:leave_count)
#byebug
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

	@all_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day )
    @show_attendance = DailyAttendance.where(user_id: current_user.id, :created_at => Time.now.beginning_of_month..Time.now.end_of_month) 

 @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

 @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

#@cal_time = @a.present? ? @a : 
#byebug
#@a =  ['18:35', '19:07', '23:09']

@avrg = @a.present? ? avg_of_times(@a) : 0 
@employe_leaves = RequestLeave.where(user: current_user.id,status: true).sum(:leave_count)
@general_holidays = GeneralHoliday.all
@request_pending = RequestLeave.where(user_id: current_user.id, status: nil).count

	end

	# Show ALl employees
	def employees
		@users = User.all.where.not(id: current_user.id)
	end


	# User Profile 
	def user_profile
		@designation = Designation.all
		@department = Department.all
		@user = User.find(current_user.id)

		@user_role = UserRole.find_by(:user_id => current_user.id)
		@user_image = UserImage.new
		@previous_image = UserImage.where(:user_id => current_user)
    @today_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day)
    @edit_current_user = UserImage.new
	end


	# Method to save user cover image and Profile image
	def save_user_image
		# @user_image = UserImage.create()
		# @user_image.image_url = params[image]
	end

	# admin edit the employees info
	def admin_edit_user
		@designation = Designation.all
		@department = Department.all
		@user = User.find(params[:id])
		@user_role = UserRole.find_by(:user_id => current_user.id)
	end

	# Admin Update the employees info
	def update_user
		@user = User.find(params[:id])
		if @user.update(custom_update_user_params)
			puts 'It is updated'
		else
			puts 'It is not updated'
		end


		
	end


	# Admin create new user
	def admin_create_user
		@designation = Designation.all
		@department = Department.all
		@role =  MasterRole.all
		@user = User.new
	end


	# Save New User and send an email

	def add_new_employee

   		generated_password = Devise.friendly_token.first(8)
   		role = params[:user][:id]
    	@user = User.new(
    		:email => params[:user][:email],
			:password => generated_password ,
			:first_name => params[:user][:name],
			:designation_id => params[:user][:designation_id],
			:department_id => params[:user][:department_id])

    	@user.user_roles.build(:master_role_id => params[:user][:id])


	    respond_to do |format|
		     if @user.save
		     	RegistrationMailer.with(user: @user,password: generated_password,role: role).welcome_user.deliver_later
		        # RegistrationMailer.welcome_user(@user, generated_password).deliver
		        format.html { redirect_to root_url, notice: 'User was successfully created.' }
		        format.json { render :show, status: :created, location: @user }
		      else
		        format.html { render :new }
		        format.json { render json: @user.errors, status: :unprocessable_entity }
		      end
    	end

	end




	



	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  @currentuser = User.find(current_user.id)
	end
end
