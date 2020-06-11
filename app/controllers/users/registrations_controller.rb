# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new

    @registered_employes = RegisterEmploye.all
    @user_roles = MasterRole.all
     super
   end

  # POST /resource


  def create
    super
  end 




   def create33

  #   @registered_employes = RegisterEmploye.all
  #  generated_password = Devise.friendly_token.first(8)
  #  #confirmation_token = SecureRandom.urlsafe_base64(10)
  #  #confirmation_sent_at = Time.now.utc
  #   @user = User.new(:email => "rajat@poplify.com", :password => 12345678 ,:name=> "sdfsdds")
  #  # @user = User.new

  #  #@user.email = params[:user][:email]
  #  #@user.password = generated_password
  #  #@user.password_confirmation = generated_password
  #  #@user.name = params[:user][:name]
  #  #@user.confirmation_token = confirmation_token
  # # @user.confirmation_sent_at = confirmation_sent_at


    
  #   respond_to do |format|
  #     if @user.save
  #       #HomeevalutionNotifier.send_signup_email(@homeevalution).deliver_now
  #       RegistrationMailer.welcome_user(@user, generated_password).deliver

  #       format.html { redirect_to root_url, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end




  #   super
   end

  # GET /resource/edit
  def edit
    @designation = Designation.all
    @department = Department.all

    @user_role = UserRole.find_by(:user_id => current_user.id)
    super
  end

  # PUT /resource
  def update
    
    super
  end


  protected

  def after_update_path_for(resource)
    
    user_profile_path   
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
