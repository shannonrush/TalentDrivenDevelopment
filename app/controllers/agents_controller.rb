class AgentsController < ApplicationController

  before_filter :check_authorization, :only => [:edit, :update]

  def index
    @agents = Agent.all
  end

  def show
    @agent = Agent.find(params[:id])
  end
  
  def update    
    if @agent.update_attributes(params[:agent])
      redirect_to(agent_dashboard_path(@agent), :notice => "Profile successfully updated")
    else
      render :action => "edit"
    end
  end
  
  protected 

  def check_authorization
    authenticate_user! # if there is no current_user redirect to sign in
    @agent = Agent.find(params[:id]) rescue nil
    redirect_to(edit_path_for_user(current_user)) unless @agent && current_user == @agent #redirect to current_user if not user
  end


end
