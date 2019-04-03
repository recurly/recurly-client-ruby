# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
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
  end
end
