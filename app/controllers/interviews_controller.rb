class InterviewsController < ApplicationController
  
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
end

