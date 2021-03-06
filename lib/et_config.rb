require './lib/errors'

class ETConfig
  attr_accessor :username, :password, :server

  def initialize config
    @username = config['exact_target_username']
    @password = config['exact_target_password']
    @server   = config['exact_target_server'] || 'webservice.s6.exacttarget.com'

    validate!
    
    ExactTarget.configure do |config|
      config.username = @username
      config.password = @password
      config.server   = @server
    end
  end

  private
  def validate!
    raise AuthorizationError, "ExactTarget username and password must be provided" if (username.blank? || password.blank?)
  end
end
