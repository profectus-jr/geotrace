class Users::AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  def authenticate
    response = AuthenticateUser.new(auth_params[:email], auth_params[:password], request).call
    json_response(response)
  end

  private

  def auth_params
    params.require(:authentication).permit(:email, :password)
  end
end
