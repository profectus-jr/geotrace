module Response

	def json_response(resource, status = :ok)
		render json: resource, status: status
	end

end
