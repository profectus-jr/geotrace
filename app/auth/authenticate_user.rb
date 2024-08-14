class AuthenticateUser
  
  def initialize(email, password, request = nil)
    @email = email
    @password = password
    @request = request
  end

  def call
    user
    return { token: encode_token, user: @user.as_json(only: [:name, :email]) }
  end

  private

  attr_reader :email, :password, :request

  def user
    @user = User.find_by!(email: email)
    raise(ExceptionHandler::AuthenticationInactiveUser) if @user.inactive?
    raise(ExceptionHandler::AuthenticationError) if !@user.authenticate(password)
    @user.update(iat: Time.zone.now.to_i)
  end

  def encode_token
    JsonWebToken.encode( id: @user.id, iat: @user.iat, name: @user.name, email: @user.email)
  end

end