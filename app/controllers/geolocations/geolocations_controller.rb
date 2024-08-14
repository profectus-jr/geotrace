class Geolocations::GeolocationsController < ApplicationController
  before_action :set_geolocation, only: [:show, :delete]
  before_action :find_geolocation, only: :create

  def create
    geolocation = Geolocation.new
    geolocation.url = geo_params[:url]
    geolocation.user_id = @current_user.id
    geolocation.geolocation = @service_response
    geolocation.city = @service_response["city"]
    geolocation.ip_address = @service_response["ip"]
    geolocation.country = @service_response["country_name"]
    geolocation.save!
    json_response({ geolocation: @service_response.merge(id: geolocation.id ) })
  end

  def index
    geolocations = Geolocation.joins(:user)
    .selected_fields
    .search_by_country(geo_params[:country])
    .search_by_city(geo_params[:city])
    .pages(geo_params[:page])
    json_response({ geolocations: geolocations })
  end

  def show
    json_response({ geolocation: @geolocation })
  end

  def delete
    @geolocation.destroy
    json_response(Message.successful_operation)
  end

  private

  def geo_params
    params.permit(:id, :city, :country, :ip_address, :url, :geolocation, :page)
  end

  def set_geolocation
    @geolocation = Geolocation.find(geo_params[:id])
  end

  def find_geolocation
    ip_address = geo_params[:ip_address]

    if ip_address.blank?
      ip_address = Resolver.get_ip_address(geo_params[:url])
    else
      params.delete :url
    end

    @service_response = Ipstack.standard_lookup(ip_address)
  end

end
