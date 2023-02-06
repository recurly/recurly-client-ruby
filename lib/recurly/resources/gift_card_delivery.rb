# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class GiftCardDelivery < Resource

      # @!attribute deliver_at
      #   @return [DateTime] When the gift card should be delivered to the recipient. If null, the gift card will be delivered immediately. If a datetime is provided, the delivery will be in an hourly window, rounding down. For example, 6:23 pm will be in the 6:00 pm hourly batch.
      define_attribute :deliver_at, DateTime

      # @!attribute email_address
      #   @return [String] The email address of the recipient.
      define_attribute :email_address, String

      # @!attribute first_name
      #   @return [String] The first name of the recipient.
      define_attribute :first_name, String

      # @!attribute gifter_name
      #   @return [String] The name of the gifter for the purpose of a message displayed to the recipient.
      define_attribute :gifter_name, String

      # @!attribute last_name
      #   @return [String] The last name of the recipient.
      define_attribute :last_name, String

      # @!attribute method
      #   @return [String] Whether the delivery method is email or postal service.
      define_attribute :method, String

      # @!attribute personal_message
      #   @return [String] The personal message from the gifter to the recipient.
      define_attribute :personal_message, String

      # @!attribute recipient_address
      #   @return [Address] Address information for the recipient.
      define_attribute :recipient_address, :Address
    end
  end
end
