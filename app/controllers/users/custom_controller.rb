class Users::CustomController < ApplicationController

include CustomHelper
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

	# Show ALl employees
	def employees
		@users = User.all.where.not(id: current_user.id)
	end


	# User Profile 
	def user_profile
		@designation = Designation.all
		@department = Department.all
		@user = User.find(params[:id])

		@user_role = UserRole.find_by(:user_id => current_user.id)
		@user_image = UserImage.new
		@previous_image = UserImage.where(:user_id => current_user)

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
			:name => params[:user][:name],
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
