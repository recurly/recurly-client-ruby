# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Errors
    ERROR_MAP = {
      "500" => "InternalServerError",
      "502" => "BadGatewayError",
      "503" => "ServiceUnavailableError",
      "304" => "NotModifiedError",
      "400" => "BadRequestError",
      "401" => "UnauthorizedError",
      "402" => "PaymentRequiredError",
      "403" => "ForbiddenError",
      "404" => "NotFoundError",
      "406" => "NotAcceptableError",
      "412" => "PreconditionFailedError",
      "422" => "UnprocessableEntityError",
      "429" => "TooManyRequestsError",
    }

    class ResponseError < Errors::APIError; end

    class ServerError < ResponseError; end

    class InternalServerError < ServerError; end

    class BadGatewayError < ServerError; end

    class ServiceUnavailableError < ServerError; end

    class RedirectionError < ResponseError; end

    class NotModifiedError < ResponseError; end

    class ClientError < Errors::APIError; end

    class BadRequestError < ClientError; end

    class InvalidContentTypeError < BadRequestError; end

    class UnauthorizedError < ClientError; end

    class PaymentRequiredError < ClientError; end

    class ForbiddenError < ClientError; end

    class InvalidApiKeyError < ForbiddenError; end

    class InvalidPermissionsError < ForbiddenError; end

    class NotFoundError < ClientError; end

    class NotAcceptableError < ClientError; end

    class UnknownApiVersionError < NotAcceptableError; end

    class UnavailableInApiVersionError < NotAcceptableError; end

    class InvalidApiVersionError < NotAcceptableError; end

    class PreconditionFailedError < ClientError; end

    class UnprocessableEntityError < ClientError; end

    class ValidationError < UnprocessableEntityError; end

    class MissingFeatureError < UnprocessableEntityError; end

    class TransactionError < UnprocessableEntityError; end

    class SimultaneousRequestError < UnprocessableEntityError; end

    class ImmutableSubscriptionError < UnprocessableEntityError; end

    class InvalidTokenError < UnprocessableEntityError; end

    class TooManyRequestsError < ClientError; end

    class RateLimitedError < TooManyRequestsError; end
  end
end
