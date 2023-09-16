class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    user_categories_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
