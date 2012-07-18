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

  protected

  def check_authorization
    authenticate_user!
  end
end

