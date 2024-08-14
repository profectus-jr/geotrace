require 'net/http'
require 'uri'
require 'json'

class OutgoingApiRequests

  def self.get_request(uri, obj = nil, header = nil, ssl = false)
    uri = URI.parse(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = ssl
    request = Net::HTTP::Get.new(uri.request_uri, header)
    response = http.request(request)
    return JSON.parse(response.body)
  end

end