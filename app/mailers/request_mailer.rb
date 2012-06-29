class RequestMailer < ActionMailer::Base
  default from: "\TDD\"shannon@talentdrivendevelopment.com"

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
end
