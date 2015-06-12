require 'open_agenda/error'

module OpenAgenda
  module ResponseHandler
    def handle(body, status)
      status = status.to_s

      case status
      when "200"
        return body.data
      when "400"
        raise BadRequestError, message(body)
      when "404"
        raise NotFoundError, message(body)
      when "500"
        raise InternalServerError, message(body)
      when /4\d{2}/
        raise ClientError, "#{status(body)} - #{message(body)}"
      when /5\d{2}/
        raise ServerError, "#{status(body)} - #{message(body)}"
      else
        raise Error, "#{status(body)} - #{message(body)}"
      end
    end

    private
      def message(body)
        body.message || ''
      end

      def status(body)
        body.code || ''
      end
  end
end
