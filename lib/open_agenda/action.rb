require 'open_agenda/path_builder'
require 'open_agenda/response_handler'
require 'multi_json'

module OpenAgenda
  class Action
    include ResponseHandler

    attr_reader :name, :verb, :path, :send_public_key, :additional_params

    def initialize(name, verb, path)
      @name, @verb, @path = name, verb, path
      @additional_params = {}
    end

    def invoke(connection, args)
      path_params, query_params = split_up_params(args)
      path_builder = PathBuilder.new(path, path_params)

      query_params[:key] = OpenAgenda.config.api_public_key if send_public_key

      additional_params.each do |name, value|
        query_params[name] = if value.is_a?(Proc)
          value.call
        else
          value
        end
      end

      puts "query params: "+query_params.inspect

      response = send(verb, connection, path_builder.build, query_params)

      puts response.inspect

      status = if response.body.respond_to?(:code)
        response.body.code
      else
        response.status
      end
      
      handle(response.body, status)
    end

    def get(connection, path, query_params = {})
      connection.get(path, query_params)
    end

    def post(connection, path, query_params = {})
      query_params[:data] = MultiJson.dump(query_params[:data])
      connection.post(path, query_params)
    end

    def with_api_public_key
      @send_public_key = true
    end

    def with_param(name, value)
      additional_params[name] = value
    end

    private
      def split_up_params(params)
        if params.last.kind_of?(Hash)
          query_params = params.last
          path_params = params[0..-2]
        else
          query_params = {}
          path_params = params
        end

        return path_params, query_params
      end
  end
end
