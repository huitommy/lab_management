class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications

  protected

  def after_sign_in_path_for(resources)
    dashboard_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  protect_from_forgery with: :exception

  def set_notifications
    @notification = Order.where(ordered: false)
  end
end
