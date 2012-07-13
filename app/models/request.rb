class Request < ActiveRecord::Base
  belongs_to :talent
  belongs_to :agent

  after_create :send_new_request_emails,:make_pending
  after_update :update_associations,:send_update_request_emails,:remove_pending
  attr_accessible :accepted, :agent_id, :message, :pending, :talent_id, :agent, :talent

  validates_inclusion_of :accepted, :on => :update, :in => [true,false]
  validate :none_outstanding

  def send_new_request_emails
    RequestMailer.new_request(self).deliver    
    RequestMailer.new_request_confirmation(self).deliver
  end

  def make_pending
    self.update_column(:pending,true)
  end

  def update_associations
    self.agent.talents << self.talent if self.accepted 
  end

  def send_update_request_emails
    RequestMailer.request_reply(self).deliver
    RequestMailer.request_reply_confirmation(self).deliver
  end

  def remove_pending
    self.update_column(:pending,false)
  end

  def none_outstanding
    if Request.where(agent_id:self.agent.id,talent_id:self.talent.id,pending:true).count > 0
      errors.add(:base, "You already have a request pending for this agent")
    end
  end
end

