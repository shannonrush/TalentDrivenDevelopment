class UsersController < ApplicationController
  
  before_filter :check_authorization, :only => [:edit, :update]
  
  def update    
    respond_to do |format|
      if @user.update_attributes(params[@user.type.downcase])
        format.html {redirect_to(user_dashboard_index_path(@user), :notice => "Profile successfully updated")}
      else
        format.html {render :action => "edit"}
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  protected
  
  def check_authorization
    authenticate_user! # if there is no current_user redirect to sign in
    @user = User.find_by_id(params[:id])
    redirect_to(edit_user_path(current_user)) unless @user && current_user == @user #redirect to current_user if not user
  end

end
