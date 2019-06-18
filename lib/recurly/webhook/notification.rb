module Recurly
  module Webhook
    # The Notification class provides a generic interface
    # for account-related webhook notifications.
    class Notification < Resource
      # Provides a convenience method to reload assocated members because Webhook
      # notifications are not to be considered current.
      def self.has_one member_name, options = {}
        define_method("#{member_name}!") do
          member = self[member_name]
          member.reload if member
        end

        super
      end
    end
  end
end
