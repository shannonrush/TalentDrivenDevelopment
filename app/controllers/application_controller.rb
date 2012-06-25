class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def edit_path_for_user(user)
    send("edit_#{user.class.name.underscore}_path",user)
  end
  
  def dashboard_path_for_user(user)
    send("#{user.class.name.underscore}_dashboard_path",user)
  end
end
