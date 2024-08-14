module ExceptionHandler

	extend ActiveSupport::Concern

	# Define custom error subclasses - rescue catches StandardErrors
	class AuthenticationError < StandardError; end
	class AuthenticationInactiveUser < StandardError; end
	class MissingToken < StandardError; end
	class InvalidToken < StandardError; end
	class ExpiredSignature < StandardError; end
	class InvalidURL < StandardError; end
	class InvalidIpAddress < StandardError; end

	included do
		rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :four_twenty_two
    rescue_from ActiveRecord::StatementInvalid, with: :four_twenty_two
    rescue_from ActionController::ParameterMissing, with: :four_twenty_two
		rescue_from ExceptionHandler::MissingToken, with: :four_ninety_eight
		rescue_from ExceptionHandler::InvalidToken, with: :four_ninety_eight
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
		rescue_from ExceptionHandler::AuthenticationError, with: :auth_error
		rescue_from ExceptionHandler::AuthenticationInactiveUser, with: :inactive_user
		rescue_from ExceptionHandler::InvalidURL, with: :invalid_url
		rescue_from ExceptionHandler::InvalidIpAddress, with: :invalid_ip_address
		
		rescue_from ActionController::RoutingError do |e|
			logger.error 'Routing error occurred'
			json_response({ message: e.message }, :unprocessable_entity)		
		end

	end

	private

	def four_twenty_two(e)
		json_response({ message: e.message }, :unprocessable_entity)
	end

	def four_zero_one(e)
		json_response(Message.unauthorized, :unauthorized)
	end

	def auth_error
		json_response(Message.auth_error, :unauthorized)
	end

	def inactive_user(e)
		json_response(Message.inactive_user, :unauthorized)
  end

	def invalid_url
		json_response(Message.invalid_url, :unauthorized)
	end

	def invalid_ip_address
		json_response(Message.invalid_ip_address, :unauthorized)
	end

	def four_ninety_eight(e)
		json_response(Message.invalid_token, 498)
  end

end
