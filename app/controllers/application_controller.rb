class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    "/user/#{current_user.id}"
  end

  protected

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_owner?
    unless @project.owner == current_user
      redirect_to root_path, alert: "You don't have access to that project."
    end
  end

  def configure_permitted_parameters
    added_attrs = [ :first_name, :last_name, :email, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
  end
end
