class Users::CustomController < ApplicationController
	include DashboardsHelper

	include CustomHelper
	#before_action :authenticate_user!, except: %i[index	show]	
	#before_action :set_user
	before_action :authenticate_user!, except: [:index, :show]
	#before_action : common_data, only: []
	 layout "dashboard"

def admindashboard



end

def common_data

end	

def add_new_holiday

	@add_new_holiday  = GeneralHoliday.create(date: params[:holiday_date], occasion: params[:occasion_name])

	respond_to do |format|
	format.html {redirect_to root_url, notice: 'New Holiday added successfully.'}

	end

end	


def monthly_attendance

          #puts params[:month]
          @user_role = UserRole.find_by(:user_id => current_user.id)

           @uid = @user_role.master_role_id == 1 ? params[:id] : current_user.id

          	@show_attendance = DailyAttendance.where("MONTH(created_at) = ? and user_id = ?", params[:month].to_i,  @uid)

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
               @update_leave.status = params[:status] 

          #@update_leave.save
          #@submit_leave = RequestLeave.new(user_id: current_user.id, subject: params[:subject], message: params[:message], date_from: @daterange[0], date_to: @daterange[2], leave_count: @count_leave)
     	respond_to do |format|
     		if @update_leave.save
     		   format.html { redirect_to request_leave_path, notice: 'Leave updated successfully' }
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
          @user_role = UserRole.find_by(user_id: params[:uid]) 
               respond_to do |format|

               format.js {render 'edit_reply_popup'}


               end
          end	
     end

def edit_current_user

	@saveuser = User.find(current_user.id)
	
	respond_to do |format|

		if @saveuser.update(edit_user_params)
		  #  @saveuser.first_name = params[:user][:first_name]
		  #  @saveuser.last_name = params[:user][:last_name]
		  #  @saveuser.date_of_birth = params[:user][:date_of_birth]
		  #  @saveuser.facebook = params[:user][:facebook]
		  #  @saveuser.instagram = params[:user][:instagram]
		  #  @saveuser.gender = params[:user][:gender]

		  #  params[:user][:image] ?  @saveuser.image = params[:user][:image] : ''

				# if @saveuser.save
				format.html { redirect_to user_profile_path, notice: 'Hey '+ params[:user][:first_name].capitalize+'! profile updated successfully. ' }	

				else

				format.html { redirect_to user_profile_path, alert: 'Hey '+ params[:user][:first_name].capitalize+'! profile not updated successfully. ' }

				end	


		end
		
end

#end

def attendance_employe

@user_role = UserRole.find_by(:user_id => current_user.id)

if @user_role.master_role_id == 1

	@show_attendance = DailyAttendance.where(user_id: params[:id]).current_month
	@avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

	@a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

	@avrg = @a.present? ? avg_of_times(@a) : 0 
   total_employe_leaves = RequestLeave.where(user_id: params[:id]) 
	@leaves_taken = total_employe_leaves.where(status: :approved).sum(:leave_count)
	@applied_leaves = total_employe_leaves.where(status: :rejected).sum(:leave_count)

else

   redirect_to attendance_path, alert: "You  don't have permission to acces this page !!"
end
end


def attendance

@user_role = UserRole.find_by(:user_id => current_user.id)

if @user_role.master_role_id == 1
      today_employes =   DailyAttendance.current_day
	@present_employes = today_employes.where(master_attendance_status_id: '1')
	@employes_on_leave = today_employes.where(master_attendance_status_id: '3')
	@users = User.all.where.not(id: current_user.id)
else	

	@show_attendance = DailyAttendance.where(user_id: current_user.id).current_month


@avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

@a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

@avrg = @a.present? ? avg_of_times(@a) : 0 
 total_employe_leaves = RequestLeave.where(user_id: current_user.id) 

@leaves_taken = total_employe_leaves.where(status: :approved).sum(:leave_count)
@applied_leaves = total_employe_leaves.where(status: :rejected).sum(:leave_count)
end

end 



	def popup_route
		
		@popup_user = User.find(params[:user_id])
		
		respond_to do |format|
			format.js
		end
	end



	# popup in admin dashboard page for edit punch in and punch out
	def popup_edit_punch
		
  #if params[:user_id].present? par

		@all_attendance = DailyAttendance.find_or_initialize_by(user_id: params[:user_id], id: params[:atend_id]  )
		@attendance_status = MasterAttendanceStatus.all
		respond_to do |format|
			format.js {render 'users/custom/js/popup_edit_punch'}
		end
	end

	# popup in admin dashboard page for edit punch in and punch out
	def popup_update_punch
	


		@attendance_update = DailyAttendance.find_or_initialize_by(user_id: params[:edit_user_punch], created_at: Date.today.all_day )


		@attendance_update.user_id = params[:edit_user_punch]

		if params[:mySelectStatus].to_i == 1
			
			params[:punch_in].present? ? @attendance_update.punch_in = DateTime.parse(params[:punch_in]).to_s : ''
			params[:punch_out].present? ? @attendance_update.punch_out = DateTime.parse(params[:punch_out]).to_s : ''

			#byebug
		end
		@attendance_update.master_attendance_status_id = params[:mySelectStatus]
		if @attendance_update.save!
			redirect_to root_url
		end
		
#byebug
end




	def punch_attendance

		@attendance = DailyAttendance.find_or_initialize_by(user_id: current_user.id,created_at: Date.today.all_day )

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
               @user_role = UserRole.find(current_user.id)
               @request_leave = RequestLeave.new
               @employe_leaves = RequestLeave.where(user: current_user.id,status: :approved).sum(:leave_count)
               #@employe_leaves = 10
               @all_leaves = RequestLeave.where(user_id: current_user.id)

               if @user_role.master_role_id == 1

               submitted_leaves = RequestLeave.all
               @applied_leaves = submitted_leaves.where(status: nil)
               @approved_leaves = submitted_leaves.where(status: :approved)
               @un_approved_leaves = submitted_leaves.where(status: :rejected)



               end 
          end

          def apply_leave
     
               @daterange = params[:dated_from].split()
               @count_leave = params[:leave_count] == 1 ? 1 : (@daterange[2].to_date - @daterange[0].to_date).to_i + 1

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
		@users = User.all.where.not(id: current_user.id).limit(5)

   #view_admin_attendance = DailyAttendance.find_by(user_id: current_user.id )
          @all_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day )
          @show_attendance = DailyAttendance.where(user_id: current_user.id).current_month

          @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

          @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}


          @avrg = @a.present? ? avg_of_times(@a) : 0 
           @general_holidays = GeneralHoliday.all
           common_leaves_admin = RequestLeave.where(user: current_user.id)
          @employe_leaves = common_leaves_admin.where(status: :approved).sum(:leave_count)
         
          @request_pending = common_leaves_admin.where(status: nil).count
          @all_pending_leaves = RequestLeave.where(status: nil).count

	end

	# Show ALl employees
	def employees

    @login_users = DailyAttendance.current_day.where( master_attendance_status_id: 1)

    myids =  [ current_user.id.to_i, @login_users.collect{|i| i.user_id.to_i} ]
    users_absent = myids.join(",").chomp.split(',').map { |x| x.to_i }
    @offline_users = User.where.not(id: users_absent)
#byebug
		#DailyAttendance.find_by( created_at: Date.today.all_day, master_attendance_status_id: 1)
	end


	# User Profile 
	def user_profile
		# @designation = Designation.all
		# @department = Department.all
		@user = User.find(current_user.id)
		@edit_current_user = User.find(current_user.id)

		@user_role = UserRole.find_by(:user_id => current_user.id)
		#@user_image = UserImage.new
		#@previous_image = UserImage.where(:user_id => current_user)

	     #@today_attendance = DailyAttendance.find_by(user_id: current_user.id, created_at: Date.today.all_day)
	

		# Get monthly average of an employee
		
		# @show_attendance = DailyAttendance.where(user_id: @user.id).current_month

		# @avrgats = @show_attendance.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }

		# @a = @avrgats.map{|n| Time.at(n).utc.strftime("%k:%M")}

		# @avrg = @a.present? ? avg_of_times(@a) : 0
		

	end




	# admin edit the employees info
	# def admin_edit_user
	# 	@designation = Designation.all
	# 	@department = Department.all
	# 	@user = User.find(params[:id])
	# 	@user_role = UserRole.find_by(:user_id => current_user.id)
	# end



	# Admin Update the employees info
     def update_user
          @user = User.find(params[:id])



          if @user.update(new_user_params)
               @user.user_roles.update(:master_role_id => params[:roleid])
               redirect_to show_path, notice: "User Updated successfully !!"

          else
                redirect_to show_path, alert: "User details not Updated successfully !!"
          end
     end


	# Admin create new user
	def admin_create_user
		@designation = Designation.all
		@department = Department.all
		@role =  MasterRole.all
		@user = User.new
	end

     def show


          @user_role = UserRole.find_by(user_id: current_user.id)
          if @user_role.master_role_id == 1
               @user = User.find(params[:id])
               @designation = Designation.all
               @department = Department.all
               @role =  MasterRole.all
               @employe_role = UserRole.find_by(user_id: params[:id])
               @show_attendance = DailyAttendance.where(user_id: params[:id]).current_month
          else

                redirect_to user_profile_path, alert: "You  don't have permission to acces this page !!"
          end 	

     end


	# Save New User and send an email

     def add_new_employee

          generated_password = Devise.friendly_token.first(8)
          role = params[:user][:id]
          @user = User.new(
          :employee_id => params[:user][:employee_id],
          :email => params[:user][:email],
          :password => generated_password ,
          :first_name => params[:user][:first_name],
          :gender => params[:user][:gender],
          :designation_id => params[:user][:designation_id],
          :department_id => params[:user][:department_id])

          @user.user_roles.build(:master_role_id => params[:user][:id])


          respond_to do |format|
               if @user.save
                    MailWorker.perform_async(@user.id,generated_password,role)
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

          def edit_user_params

              params.require(:user).permit( :first_name, :last_name, :gender, :date_of_birth, :instagram, :facebook, :image)

          end 


          def new_user_params

               params.require(:user).permit(:employee_id, :first_name, :designation_id, :department_id, :email)
          end

end
