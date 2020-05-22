# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
	def welcome_user

    # Set up a temporary order for the preview
    @user = User.new(
    	email: 'rahul+12398@poplify.com',
    	password: '12345678',
    	name: "Joe Smith",designation_id: 1,department_id: 2)

    @user.user_roles.build(:master_role_id => 2)

	if @user.save!
    	RegistrationMailer.with(user: @user,password: 12312312,role: 1).welcome_user
    end
  end

end
