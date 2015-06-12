require 'open_agenda/error'

module OpenAgenda
  module ResponseHandler
    def handle(body, status)
      status = status.to_s

      case status
      when "200"
        return body
      when "400"
        raise BadRequestError
      when "404"
        raise NotFoundError
      when "500"
        raise InternalServerError
      when /4\d{2}/
        raise ClientError
      when /5\d{2}/
        raise ServerError
      else
        raise Error
      end
    end
  end
end
