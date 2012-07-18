class InterviewsController < ApplicationController

  before_filter :check_authorization

  def new
    @interview = Interview.new(talent_id:params[:talent_id])
  end

  def create
    @interview = Interview.new(params[:interview])
    if @interview.save
      redirect_to interviews_path, :notice => "Interview offer sent!"
    else
      render :action => :new
    end   
  end

  def index
    @interviews = current_user.interviews
  end

  def update
    if @interview.update_attributes(params[:interview])
      redirect_to talent_dashboard_path(current_user), :notice => "Your interview has been updated and your agent has been notified"
    else
      render :action => "edit"
    end  
  end

  protected

  def check_authorization
    authenticate_user!
    if ["edit","update"].include? params[:action]
      @interview = Interview.find params[:id]
      unless current_user == @interview.talent
        redirect_to dashboard_path_for_user(current_user), :notice => "This does not appear to be your interview. Please try again."
      end
    end
  end
end

