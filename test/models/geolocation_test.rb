require "test_helper"

class GeolocationTest < ActiveSupport::TestCase

  def setup
    @geolocation_one = geolocations(:one)
    @geolocation_two = geolocations(:two)
  end

  test 'valid geolocation' do
    assert @geolocation_one.valid?
  end

  test "should not save blank user" do
    geolocation = Geolocation.new
    assert_not geolocation.save
  end

  test "should not save geolocation without ip address" do
    @geolocation_one.ip_address = nil
    refute @geolocation_one.valid? "Saved geolocation without a IP Address"
  end

  test "geolocation must have unique ip address" do
    @geolocation_two.ip_address = @geolocation_one.ip_address
    refute @geolocation_two.valid?
  end

  test "geolocation must belong to a user" do
    @geolocation_one.user_id = nil
    refute @geolocation_one.valid?
  end

end
