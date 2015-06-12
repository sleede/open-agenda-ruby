require 'open_agenda/path_builder'

module OpenAgenda
  class Action
    attr_reader :name, :verb, :path, :send_public_key

    def initialize(name, verb, path)
      @name, @verb, @path = name, verb, path
    end

    def invoke(connection, args)
      path_params, query_params = split_up_params(args)

      path_builder = PathBuilder.new(path, path_params)

      query_params[:key] = OpenAgenda.config.api_public_key if send_public_key
      send(verb, connection, path_builder.build, query_params)
    end

    def get(connection, path, query_params = {})
      connection.get(path, query_params)
    end

    def with_api_public_key
      @send_public_key = true
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
