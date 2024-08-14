class ErrorsController < ApplicationController
  skip_before_action :authorize_request

  def routing_error
    raise ActionController::RoutingError.new("No such route exists")
  end

end
