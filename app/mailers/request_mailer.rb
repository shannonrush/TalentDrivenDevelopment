class RequestMailer < ActionMailer::Base
  default from: "\TDD\"support@talentdrivendevelopment.com"

  def new_request(request)
    # sent to agent from talent upon requests#create
    @request = request
    mail(
      :to => request.agent.email,
      :subject => "#{request.talent.first_name} Requests Representation"
    )
  end

  def new_request_confirmation(request)
    # sent to requesting talent upon requests#create
    @request = request
    mail(
      :to => request.talent.email,
      :subject => "Confirmation of Request"
    )
  end
  
  def request_reply(request)
    # sent to requesting talent upon requests#update
    @request = request
    mail(
      :to => request.talent.email,
      :subject => "Your Request For Representation"
    )
  end

  def request_reply_confirmation(request)
    #sent to requested agent upon requests#update
    @request = request
    mail(
      :to => request.agent.email,
      :subject => "Your Reply Has Been Received"
    )
  end
end
