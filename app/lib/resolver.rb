require 'resolv'
require 'open-uri'

class Resolver
  
  def self.get_ip_address(url)
    Resolv.getaddresses(valid_url(url))[0]
  rescue
    raise(ExceptionHandler::InvalidURL)
  end

  def self.valid_ip_address(ip_address)
    return true if ((ip_address =~ Resolv::IPv4::Regex) || (ip_address =~ Resolv::IPv6::Regex))
    raise(ExceptionHandler::InvalidIpAddress)
  end

  private

  def self.valid_url(url)
    raise(ExceptionHandler::InvalidURL) if url.blank?
    status = URI.open(url).status
    raise(ExceptionHandler::InvalidURL) if status[0] != "200"
    return URI(url).hostname
  end

end