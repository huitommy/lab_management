class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications

  protected

  def after_sign_in_path_for(resources)
    dashboard_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :password, :password_confirmation, :remember_me ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login, :username, :email, :password, :remember_me ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :email, :password, :password_confirmation, :current_password ])
  end

  protect_from_forgery with: :exception

  def set_notifications
    @notification = Order.where(ordered: false)
  end
end
