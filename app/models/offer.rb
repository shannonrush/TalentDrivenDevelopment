class Offer < ActiveRecord::Base
  attr_accessible :acceptable, :accepted, :agent_id, :agent, :comment, :description, :entity, :talent_id, :talent

  belongs_to :agent
  belongs_to :talent

  validates_presence_of :agent_id, :talent_id, :entity, :description
  validates_inclusion_of :acceptable, :in => [true,false], :on => :update, :message => "must be selected"
  validates_inclusion_of :accepted, :in => [true,false], :on => :update, :message => "must be selected"

  after_create :send_offer
  after_update :send_offer_reply

  protected

  def send_offer
    OfferMailer.offer(self).deliver 
  end

  def send_offer_reply
    OfferMailer.offer_reply(self).deliver
  end
end
