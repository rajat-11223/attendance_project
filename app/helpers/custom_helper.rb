module CustomHelper
	def custom_update_user_params
		params.require(:user).permit(:employee_id, :first_name, :last_name, :gender, :designation_id, :department_id, :email, :dob, :instagram, :facebook)
	end
end