class Message
  
  def self.not_found(record = 'record')
    { message: "Sorry, #{record} not found.", status: 404}
  end

  def self.invalid_token
    { message: 'Invalid token', status: 403 }
  end

  def self.inactive_user
    { message: "Inactive user", status: 401 }
  end

  def self.expired_token
    { message: "Token expired", status: 401 }
  end

  def self.successful_operation
    { message: 'Successful operation', status: 201 }
  end

  def self.auth_error
    { message: 'Authentication error (invalid email/password)', status: 403 }
  end

  def self.invalid_url
    { message: 'Invalid URL', status: 403 }
  end

  def self.invalid_ip_address
    { message: 'Invalid IP Address', status: 403 }
  end

end