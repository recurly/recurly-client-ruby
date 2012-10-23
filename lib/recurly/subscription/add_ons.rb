module Recurly
  class Subscription < Resource
    class AddOns
      instance_methods.each do |method|
        undef_method method if method !~ /^__|^(object_id|respond_to\?|send)$/
      end

      # @param subscription [Subscription]
      # @param add_ons [Array, nil]
      def initialize subscription, add_ons = []
        @subscription, @add_ons = subscription, []
        add_ons and add_ons.each { |a| self << a }
      end

      # @return [self]
      # @param add_on [AddOn, String, Symbol, Hash] A {Plan} add-on,
      #   +add_on_code+, or hash with optional <tt>:quantity</tt> and
      #   <tt>:unit_amount_in_cents</tt> keys.
      # @example
      #   pp subscription.add_ons << '1YEARWAR' << '1YEARWAR' << :BONUS
      #   [
      #     {:add_on_code => "1YEARWAR", :quantity => 2},
      #     {:add_on_code => "BONUS"}
      #   ]
      def << add_on
        add_on = SubscriptionAddOn.new(add_on, @subscription)

        exist = @add_ons.find { |a| a.add_on_code == add_on.add_on_code }
        if exist
          exist.quantity ||= 1 and exist.quantity += 1

          if add_on.unit_amount_in_cents
            exist.unit_amount_in_cents = add_on.unit_amount_in_cents
          end
        else
          @add_ons << add_on
        end

        self
      end

      def to_a
        @add_ons.dup
      end

      def errors
        @add_ons.map { |add_on| add_on.errors }
      end

      def to_xml options = {}
        builder = options[:builder] || XML.new('<subscription_add_ons/>')
        @add_ons.each do |add_on|
          node = builder.add_element 'subscription_add_on'
          add_on.attributes.each_pair do |k, v|
            node.add_element k.to_s, v if v
          end
        end
        builder.to_s
      end

      def respond_to? method_name, include_private = false
        super || @add_ons.respond_to?(method_name, include_private)
      end

      private

      def method_missing name, *args, &block
        if @add_ons.respond_to? name
          return @add_ons.send name, *args, &block
        end

        super
      end
    end
  end
end
