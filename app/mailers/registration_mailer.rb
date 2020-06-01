class RegistrationMailer < ApplicationMailer
	def welcome_user
		@user = params[:user]
		@password = params[:password]
		@role_id = params[:role]

		mail(to: @user.email, subject: "Account Activated")
	end
	
end
