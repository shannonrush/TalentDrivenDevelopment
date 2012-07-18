module InterviewsHelper

  def accepted_text(interview)
    if interview.accepted.nil?
      "No Response"
    else
      interview.accepted ? "Yes" : "No"
    end
  end

  def unacceptable_class(interview)
    interview.acceptable || interview.acceptable.nil? ? "" : "unacceptable"
  end

  def talent_or_agent(interview, current_user)
    current_user.agent? ? interview.talent.full_name : interview.agent.full_name
  end
end
