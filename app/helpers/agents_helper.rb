module AgentsHelper
  def show_request?(current_user)
    current_user.kind_of?(Talent) ? true : false
  end

  def request_by_availability(agent)
    agent.available? ? "request" : "unavailable"
  end  
end
