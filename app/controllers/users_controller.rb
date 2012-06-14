class UsersController < ApplicationController
  
  before_filter :authorized_to_edit, :only => [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[@user.type.downcase])
        format.html {redirect_to(@user, :notice => "Profile successfully updated")}
      else
        format.html {render :action => "edit"}
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  protected
  
  def authorized_to_edit
    authenticate_user! # if there is no current_user redirect to sign in
    user = User.find_by_id(params[:id])
    redirect_to(edit_user_path(current_user)) unless user && current_user == user
  end

end
