class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def after_sign_up_path_for(resource)
      user_path(resource)
	end
  	
  	
	def after_sign_in_path_for(resource)
 	  user_path(resource)
	end
  

	def configure_permitted_parameters
		added_attrs = [ :name, :email, :password, :password_confirmation]
		devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
	end
end


