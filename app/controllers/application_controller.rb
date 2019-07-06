class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
	    timecard_path(current_user.id) # マイページへ
	end

	def after_sign_out_path_for(resource)
	    root_path # ログアウト後に遷移するpathを設定
	end
  
  	protected
  
  	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :employee_code,:password, :password_confirmation) }
	    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:employee_code, :password, :password_confirmation) }
  	end
end
