class Users::CustomController < ApplicationController
	before_action :set_user, only: [ :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]


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