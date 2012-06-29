class Request < ActiveRecord::Base
  belongs_to :talent
  belongs_to :agent

  after_create :send_new_request_emails,:make_pending

  attr_accessible :accepted, :agent_id, :message, :pending, :talent_id

  def send_new_request_emails
    RequestMailer.new_request(self).deliver    
    RequestMailer.new_request_confirmation(self).deliver
  end

  def make_pending
    self.update_attributes(pending:true)
  end

end

