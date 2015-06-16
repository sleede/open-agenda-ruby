require 'faraday_middleware'
require 'open_agenda/error'
require File.expand_path('../resources/agenda_resource', __FILE__)
require File.expand_path('../resources/event_resource', __FILE__)
require File.expand_path('../resources/location_resource', __FILE__)
require File.expand_path('../response_handler', __FILE__)
require 'json'

module OpenAgenda
  class Client
    include ResponseHandler

    BASE_URI = 'https://api.openagenda.com/v1/'

    attr_reader :access_token, :expires_in

    def initialize(opts = {})
      @access_token = opts[:access_token]
      @expires_in = opts[:expires_in]
    end

    def authenticate(opts = {})
      secret_key = opts[:secret_key] || api_secret_key
      response = connection.post('requestAccessToken', { code: secret_key })
      data = handle(response.body, response.status, true)
      parsed_data = JSON.parse(data)
      @access_token = parsed_data['access_token']
      @expires_in = parsed_data['expires_in']
      puts "client :"+self.inspect
      return access_token, expires_in
    end

    def connection
      Faraday.new(connection_options) do |conn|
        conn.request :url_encoded
        conn.headers['Accept'] = 'application/json'
        conn.use FaradayMiddleware::Mashify
        conn.response :json, :content_type => /\bjson$/
        conn.response :logger if logger?
        conn.adapter :net_http
      end
    end

    def self.resources
      {
        agendas: AgendaResource,
        events: EventResource,
        locations: LocationResource
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

      def api_secret_key
        OpenAgenda.config.api_secret_key
      end

      def logger?
        OpenAgenda.config.logger
      end
  end
end
