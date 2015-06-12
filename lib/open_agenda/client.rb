require 'faraday_middleware'
require File.expand_path('../resources/agenda_resource', __FILE__)
require File.expand_path('../resources/event_resource', __FILE__)

module OpenAgenda
  class Client
    BASE_URI = 'https://api.openagenda.com/v1/'

    attr_reader :access_token, :expires_in

    def initialize(opts = {})
      @access_token = opts[:access_token]
      @expires_in = opts[:expires_in]
    end

    def connection
      Faraday.new(connection_options) do |conn|
        conn.use FaradayMiddleware::Mashify
        conn.response :json, :content_type => /\bjson$/
        conn.adapter :net_http
      end
    end

    def self.resources
      {
        agendas: AgendaResource,
        events: EventResource
      }
    end

    def resources
      @resources ||= {}
    end

    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(connection: connection)
      else
        super
      end
    end

    private
      def connection_options
        {
          url: BASE_URI
        }
      end
  end
end
