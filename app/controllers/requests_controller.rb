class RequestsController < ApplicationController
  
  before_filter :check_authorization, :only => [:edit,:update]

  def new
    @agent = Agent.find(params[:agent_id])
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    if @request.save
      redirect_to talent_dashboard_path(current_user), :notice => "Request for Representation Sent!"
    else
      render :action => :new
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    if @request.update_attributes(params[:request])
      redirect_to(dashboard_path_for_user(current_user), :notice => "Your reply has been acknowledged")
    else
      render :action => "edit"
    end  
  end
protected

  def check_authorization
    authenticate_user!
    @request = Request.find(params[:id])
    redirect_to dashboard_path_for_user(current_user) unless current_user == @request.agent
  end
end

