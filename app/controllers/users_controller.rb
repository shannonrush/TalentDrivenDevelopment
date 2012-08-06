class UsersController < ApplicationController
  
  before_filter :check_authorization, :only => [:edit, :update]
  before_filter :check_path, :only => :show

  def index
    @users = other_user_type.all
  end

  def update    
    if @user.update_attributes(params[@user.type.downcase])
      redirect_to(dashboard_path_for_user(@user), :notice => "Profile successfully updated")
    else
      render :action => "edit"
    end
  end
  
  protected
  
  def check_authorization
    authenticate_user! # if there is no current_user redirect to sign in
    @user = User.find(params[:id])
    redirect_to(edit_path_for_user(current_user)) unless @user && current_user == @user #redirect to current_user if not user
  end

  def check_path
    @user = User.find(params[:id])
    unless request.path[@user.type.downcase]
      redirect_to profile_path_for_user(@user)
    end
  end

end
