module InterviewMailerHelper

  def interview_reply(interview)
    if interview.acceptable
      interview.accepted ? "accepted" : "rejected"
    else
      "unacceptable"
    end
  end
end
