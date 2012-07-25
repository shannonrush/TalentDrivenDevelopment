class DashboardsController < ApplicationController

  before_filter :check_authorization

  protected

  def check_authorization
    authenticate_user! # if there is no current_user redirect to sign in
    @user = User.find(params[:user_id])
    redirect_to(dashboard_path_for_user(current_user)) unless @user && current_user == @user #redirect to current_user if not user
  end

end
