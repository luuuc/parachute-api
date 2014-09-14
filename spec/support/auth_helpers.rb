module AuthHelpers
  def authWithUser (user)
    request.headers['Authorization'] = "Token token=#{user.authentication_token}"
  end

  def clearToken
    request.headers['Authorization'] = nil
  end
end