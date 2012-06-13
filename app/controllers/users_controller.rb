class UsersController < ApplicationController

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

end
