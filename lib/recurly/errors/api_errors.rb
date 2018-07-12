module Recurly
  module Errors
    class BadRequestError < Errors::APIError; end

    class InternalServerError < Errors::APIError; end

    class ImmutableSubscriptionError < Errors::APIError; end

    class InvalidApiKeyError < Errors::APIError; end

    class InvalidApiVersionError < Errors::APIError; end

    class InvalidContentTypeError < Errors::APIError; end

    class InvalidPermissionsError < Errors::APIError; end

    class InvalidTokenError < Errors::APIError; end

    class NotFoundError < Errors::APIError; end

    class SimultaneousRequestError < Errors::APIError; end

    class TransactionError < Errors::APIError; end

    class UnauthorizedError < Errors::APIError; end

    class UnavailableInApiVersionError < Errors::APIError; end

    class UnknownApiVersionError < Errors::APIError; end

    class ValidationError < Errors::APIError; end

    class MissingFeatureError < Errors::APIError; end
  end
end
