class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def edit_path_for_type(user)
    send("edit_#{user.class.name.underscore}_path",user)
  end
end
