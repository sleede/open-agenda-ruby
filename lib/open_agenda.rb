require 'open_agenda/client'
require 'open_agenda/version'
require 'open_agenda/authentication'

module OpenAgenda

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield config
  end

  class Config
    attr_accessor :api_public_key, :api_secret_key, :logger

    def initialize
      @api_public_key, @api_secret_key, @logger = nil, nil, nil
    end
  end
end
