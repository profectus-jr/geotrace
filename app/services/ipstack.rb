require 'net/http'
require 'uri'

class Ipstack

  def self.standard_lookup(ip_address)
    Resolver.valid_ip_address(ip_address)
		OutgoingApiRequests.get_request(ipstack_credentials(ip_address))
  end

  private

  def self.ipstack_credentials(ip_address)
    Rails.application.credentials[:ipstack][:base_url] +
    ip_address +
    "?access_key=#{Rails.application.credentials[:ipstack][:access_key]}"
  end

end