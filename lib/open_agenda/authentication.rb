# require 'faraday_middleware'
#
# module OpenAgenda
#   module Authentication
#     def authenticate(api_private_key: nil, connection)
#       api_private_key = api_private_key || private_key
#       conn = connection || default_connection
#     end
#
#     private
#       def private_key
#         ''
#       end
#
#       def default_connection
#         Faraday.new(connection_options) do |conn|
#           conn.use FaradayMiddleware::Mashify
#           conn.response :json, :content_type => /\bjson$/
#           conn.adapter :net_http
#         end
#       end
#   end
# end
