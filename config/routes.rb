Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: "users", path: "users" do
    post 'authenticate', to: 'authentication#authenticate'
  end

  scope module: "geolocations", path: "geolocations" do 
    post 'create', to: 'geolocations#create'
    get 'show', to: 'geolocations#show'
    get 'list', to: 'geolocations#index'
    delete 'delete', to: 'geolocations#delete'
  end

	match '*path', to: 'errors#routing_error', via: :all, constraints: lambda { |req|
		req.path.exclude? 'rails/active_storage'
	}
end
