class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected

  def edit_path_for_user(user)
    send("edit_#{user.class.name.underscore}_path",user)
  end
  
  def dashboard_path_for_user(user)
    send("#{user.class.name.underscore}_dashboard_path",user)
  end

  def after_sign_in_path_for(resource)
    dashboard_path_for_user(resource)
  end
end
