class NotificationMailer < ActionMailer::Base
  default from: "\TDD\"support@talentdrivendevelopment.com"

  def notify(notification)
    # sent to talent when agent has become available
    @notification = notification
    mail(
      :to => notification.talent.email,
      :subject => "#{notification.agent.full_name} Is Available"
    )
  end
end
