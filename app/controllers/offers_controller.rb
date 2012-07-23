class OffersController < ApplicationController

  before_filter :check_authorization
  before_filter :disallow_multiple_updates, :only => [:edit,:update]

  def new
    @offer = Offer.new(talent_id:params[:talent_id])
  end

  def create
    @offer = Offer.new(params[:offer])
    if @offer.save
      redirect_to offers_path, :notice => "Offer sent!"
    else
      render :action => :new
    end   
  end

  def update
    if @offer.update_attributes(params[:offer])
      redirect_to talent_dashboard_path(current_user), :notice => "Your offer has been updated and your agent has been notified"
    else
      render :action => "edit"
    end  
  end

  protected

  def check_authorization
    authenticate_user!
    if ["edit","update"].include? params[:action]
      @offer = Offer.find params[:id]
      unless current_user == @offer.talent
        redirect_to dashboard_path_for_user(current_user), :notice => "This does not appear to be your offer. Please try again."
      end
    end
  end

  def disallow_multiple_updates
    unless @offer.acceptable.nil? && @offer.accepted.nil?
      redirect_to dashboard_path_for_user(current_user), :notice => "You have already responded to this offer."
    end
  end

end
