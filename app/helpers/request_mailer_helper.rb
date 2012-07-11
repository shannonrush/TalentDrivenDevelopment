module RequestMailerHelper
  def reply(request)
    request.accepted ? "accepted" : "rejected"
  end
end
