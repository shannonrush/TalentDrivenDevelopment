class InterviewMailer < ActionMailer::Base
  default from: "\TDD\"support@talentdrivendevelopment.com"

  def interview_offer(interview)
    # sent to talent upon interviews#create
    @interview = interview
    mail(
      :to => interview.talent.email,
      :subject => "Interview Offer"
    )
  end
end
