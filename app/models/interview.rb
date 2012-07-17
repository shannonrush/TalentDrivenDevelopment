class Interview < ActiveRecord::Base
  attr_accessible :acceptable, :accepted, :agent_id, :agent, :description, :entity, :talent_id, :talent
  belongs_to :agent
  belongs_to :talent
  validates_presence_of :agent_id, :talent_id, :entity, :description
  validates_inclusion_of :acceptable, :in => [true,false], :on => :update
  validates_inclusion_of :accepted, :in => [true,false], :on => :update
  after_create :send_interview_offer

  protected

  def send_interview_offer
    InterviewMailer.interview_offer(self).deliver  
  end

end
