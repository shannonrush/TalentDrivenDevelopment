module InterviewsHelper

  def accepted_text(interview)
    if interview.accepted.nil?
      "No Response"
    else
      interview.accepted ? "Yes" : "No"
    end
  end

  def unacceptable_class(interview)
    interview.acceptable || interview.acceptable.nil? ? nil : "unacceptable"
  end

  def talent_or_agent(interview, current_user)
    current_user.agent? ? "Talent: #{interview.talent.full_name}" : "Agent: #{interview.agent.full_name}"
  end

  def needs_response(interview, current_user)
    interview.talent == current_user && interview.accepted.nil?
  end
end
