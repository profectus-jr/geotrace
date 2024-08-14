require "test_helper"

class Geolocations::GeolocationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @geolocation = geolocations(:one)
    @geolocations = Geolocation.all
    user = users(:john)
    @token = JsonWebToken.encode( id: user.id, iat: Time.now.to_i, name: user.name, email: user.email)
  end

  test 'should find and show geolocation' do
    geo = Geolocation.find_by(ip_address: @geolocation.ip_address)
    assert_equal geo.ip_address, @geolocation.ip_address
    get "/geolocations/show?id=#{geo.id}", headers: { "HTTP_AUTHORIZATION" => @token }
    assert_equal "show", @controller.action_name
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal "203.60.21.209", json_response["geolocation"]["ip_address"]
  end

  test 'should delete geolocation' do
    @geolocation.destroy
    geo = Geolocation.find_by(ip_address: @geolocation.ip_address)
    assert geo.nil?
  end

  test 'should create geolocation from ip address' do
    post "/geolocations/create",
      params: { ip_address: "201.60.21.208" },
      headers: { "HTTP_AUTHORIZATION" => @token }
    assert_equal "create", @controller.action_name
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert !json_response["geolocation"]["id"].nil?
    assert_equal "201.60.21.208", json_response["geolocation"]["ip"]
  end

  test 'should create geolocation from url' do
    post "/geolocations/create",
      params: { url: "https://www.nba.com" },
      headers: { "HTTP_AUTHORIZATION" => @token }
    assert_equal "create", @controller.action_name
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert !json_response["geolocation"]["id"].nil?
    geo = Geolocation.find(json_response["geolocation"]["id"])
    assert_equal "https://www.nba.com", geo.url
  end

end
