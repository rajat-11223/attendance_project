class RegistrationMailer < ApplicationMailer
	def welcome_user
		@user = params[:user]
		@password = params[:password]
		@role_id = params[:role]

		mail(to: @user.email, subject: "Account Activated")
	end	
	handle_asynchronously :welcome_user, :run_at => Proc.new { 2.minutes.from_now }
end
