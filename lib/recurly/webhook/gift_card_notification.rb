module Recurly
  module Webhook
    class GiftCardNotification < Notification
      has_one :gift_card

    end
  end
end