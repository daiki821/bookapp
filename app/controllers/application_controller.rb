class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    appdate_attrs = [ :avatar, :email, :username, :introduction, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: appdate_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
