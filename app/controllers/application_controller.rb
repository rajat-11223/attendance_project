class ApplicationController < ActionController::Base


	def stored_location_for(resource_or_scope)
		
    	session[:user_return_to] || edit_user_registration_path
  	end
end
