require 'net/https'
class Net::HTTP
  alias orig_initialize initialize
  def initialize(*args,&blk)
    orig_initialize(*args,&blk)
    self.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs') # Ubuntu
    #self.ca_file = '/opt/local/share/curl/curl-ca-bundle.crt' if File.exists?('/opt/local/share/curl/curl-ca-bundle.crt') # Mac OS X
  end
end
