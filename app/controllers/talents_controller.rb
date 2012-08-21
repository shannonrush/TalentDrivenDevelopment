class TalentsController < ApplicationController
  before_filter :check_authorization, :only => [:edit, :update]

  def index
    search = Talent.search do 
      fulltext params[:search]
      with :public, true
    end
    @talents = search.results
  end
  
  def show
    @talent = Talent.find(params[:id])
  end
  
  def update    
    if @talent.update_attributes(params[:talent])
      redirect_to(talent_dashboard_path(@talent), :notice => "Profile successfully updated")
    else
      render :action => "edit"
    end
  end

  
  protected 

  def check_authorization
    authenticate_user! # if there is no current_user redirect to sign in
    @talent = Talent.find(params[:id]) rescue nil
    redirect_to(edit_path_for_user(current_user)) unless @talent && current_user == @talent #redirect to current_user if not user
  end

end
