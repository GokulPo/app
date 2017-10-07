class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :danger, :info, :success, :warning

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :password, :password_confirmation, :current_password, :avatar) }
  end

   def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore

   flash[:danger] = "you are no cool enough to perform this action"
   redirect_to(request.referrer || root_path)
 end
end
