class NotificationsController < ApplicationController

  def create
    notification = Notification.new(agent_id:params[:agent_id],talent_id:current_user.id)
    if notification.save
      redirect_to agent_path(params[:agent_id]), :notice => "You will be notified!"
    else
      redirect_to dashboard_path_for_user(current_user), :notice => "Sorry, something went wrong"
    end
  end
end
