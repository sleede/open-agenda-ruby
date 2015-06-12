module OpenAgenda
  class Error < StandardError; end

  class ClientError < Error; end
  class BadRequestError < ClientError; end
  class NotFoundError < ClientError; end

  class ServerError < Error; end
  class InternalServerError < ServerError; end
end
