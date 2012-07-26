class Interview < ActiveRecord::Base
  attr_accessible :acceptable, :accepted, :agent_id, :agent, :description, :entity, :talent_id, :talent

  scope :accepted, where(accepted:true)
  scope :for_agent, lambda {|agent| where('agent_id = ?',agent)} 

  belongs_to :agent
  belongs_to :talent

  validates_presence_of :agent_id, :talent_id, :entity, :description
  validates_inclusion_of :acceptable, :in => [true,false], :on => :update, :message => "must be selected"
  validates_inclusion_of :accepted, :in => [true,false], :on => :update, :message => "must be selected"
  
  after_create :send_interview_offer
  after_update :send_interview_reply, :update_badges 

  protected

  def send_interview_offer
    InterviewMailer.interview_offer(self).deliver  
  end
  
  def send_interview_reply
    InterviewMailer.interview_reply(self).deliver
  end

  def update_badges
    # Interview Wonder badge is awarded upon 5th accepted interview
    if Interview.accepted.for_agent(self.agent).count == 5
      agent.badges << Badge.find_by_name("Interview Wonder")
    end
  end

end
