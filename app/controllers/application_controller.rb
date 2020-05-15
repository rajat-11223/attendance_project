class ApplicationController < ActionController::Base



#before_action :configure_permitted_parameters, if: :devise_controller?
 #before_action :persist_last_visited_path, :authenticate_user!,  except: [:home]

#before_action :after_sign_in_path_for
protect_from_forgery

protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:account_update, keys: [:name,:image,:gender,:dob,:phone])
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:image,:gender,:dob,:phone])
  #end


  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)

  resource.sign_in_count <= 1 ? edit_user_registration_path  : root_url
    #stored_location_for(resource) || edit_user_registration_path



  end 


  #protected
#
#  #def configure_permitted_parameters
#  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :gender, :designation_id, :department_id, :instagram, :facebook, :image])
#  #end
#
#  #def configure_account_update_params
#  #  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :gender, :designation_id, :department_id, :instagram, :facebook, :image])
#  #end
#
#  #def stored_location_for(resource_or_scope)
#  #  edit_user_registration_path
  #end



end
