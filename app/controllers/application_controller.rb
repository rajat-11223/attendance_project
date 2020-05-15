class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :configure_account_update_params, if: :devise_controller?
 



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :gender, :designation_id, :department_id, :instagram, :facebook, :image])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :gender, :designation_id, :department_id, :instagram, :facebook, :image])
  end

  def stored_location_for(resource_or_scope)
    edit_user_registration_path
  end


end
