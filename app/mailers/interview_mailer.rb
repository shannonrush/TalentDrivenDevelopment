class InterviewMailer < ActionMailer::Base
  default from: "\TDD\support@talentdrivendevelopment.com"

  def interview_offer(interview)
    # sent to talent upon interviews#create
    @interview = interview
    mail(
      :to => interview.talent.email,
      :subject => "Interview Offer"
    )
  end

  def interview_reply(interview)
    # sent to agent upon interviews#update
    @interview = interview
    mail(
      to:interview.agent.email,
      subject:"Interview Reply"
    )
  end
end
