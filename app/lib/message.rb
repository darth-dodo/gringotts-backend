class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found"
  end

  def self.invalid_credentials
    'Invalid credentials!'
  end

  def self.invalid_token
    'Invalid token!'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized Request'
  end

  def self.expired_token
    'Sorry ,your token has expired! Please login to continue'
  end

  def self.user_created
    'User successfully created!'
  end

  def self.account_created
    'Account successfully created!'
  end

  def self.default_error_message
    'Something went wrong!'
  end

end
