class Offer < ActiveRecord::Base
  attr_accessible :acceptable, :accepted, :agent_id, :agent, :comment, :description, :entity, :talent_id, :talent

  scope :acceptable, where(acceptable:true)
  scope :accepted, where(accepted:true)
  scope :for_agent, lambda {|agent| where('agent_id = ?',agent)}

  belongs_to :agent
  belongs_to :talent

  validates_presence_of :agent_id, :talent_id, :entity, :description
  validates_inclusion_of :acceptable, :in => [true,false], :on => :update, :message => "must be selected"
  validates_inclusion_of :accepted, :in => [true,false], :on => :update, :message => "must be selected"

  after_create :send_offer
  after_update :send_offer_reply, :update_badges

  protected

  def send_offer
    OfferMailer.offer(self).deliver 
  end

  def send_offer_reply
    OfferMailer.offer_reply(self).deliver
  end

  def update_badges
    # Offer Master badge is awarded upon 5 acceptable offers
    if Offer.acceptable.for_agent(self.agent).count == 5
      self.agent.badges << Badge.find_by_name("Offer Master")
    end  

    # Happy Talents badge is awarded upon 5 accepted offers
    if Offer.accepted.for_agent(self.agent).count == 5
      self.agent.badges << Badge.find_by_name("Happy Talents")
    end
  end
end
