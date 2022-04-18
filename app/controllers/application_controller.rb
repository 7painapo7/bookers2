class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
	user_path(resource) # ログイン後に遷移するpathを設定
	end
	def after_sign_out_path_for(resource)
	root_path(resource) # ログアウト後に遷移するpathを設定
	end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
