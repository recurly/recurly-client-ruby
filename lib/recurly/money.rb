module Recurly
  # Represents a collection of currencies (in cents).
  class Money
    # @return A money object representing multiple currencies (in cents).
    # @param currencies [Hash] A hash of currency codes and amounts.
    # @example
    #   # 12 United States dollars.
    #   Recurly::Money.new :USD => 12_00
    #
    #   # $9.99 (or €6.99).
    #   Recurly::Money.new :USD => 9_99, :EUR => 6_99
    #
    #   # Using a default currency.
    #   Recurly.default_currency = 'USD'
    #   Recurly::Money.new(49_00) # => #<Recurly::Money USD: 49_00>
    def initialize currencies = {}, parent = nil, attribute = nil
      @currencies = {}
      @parent = parent
      @attribute = attribute

      if currencies.respond_to? :each_pair
        currencies.each_pair { |key, value| @currencies[key.to_s] = value }
      elsif Recurly.default_currency
        self[Recurly.default_currency] = currencies
      else
        message = 'expected a Hash'
        message << ' or Numeric' if Recurly.default_currency
        message << " but received #{currencies.class}"
        raise ArgumentError, message
      end
    end

    def [] code
      currencies[code.to_s]
    end

    def []= code, amount
      currencies[code.to_s] = amount
      @parent.send "#@attribute=", dup if @parent
      amount
    end

    # @return [Hash] A hash of currency codes to amounts.
    def to_hash
      currencies.dup
    end

    # @return [true, false] Whether or not the currency is equal to another
    # instance.
    # @param other [Money]
    def eql? other
      other.respond_to?(:currencies) && currencies.eql?(other.currencies)
    end

    # @return [Integer] Unique identifier.
    # @see Hash#hash
    def hash
      currencies.hash
    end

    # Implemented so that solitary currencies can be compared and sorted.
    #
    # @return [-1, 0, 1]
    # @param other [Money]
    # @example
    #   [Recurly::Money.new(2_00), Recurly::Money.new(1_00)].sort
    #   # => [#<Recurly::Money USD: 1_00>, #<Recurly::Money USD: 2_00>]
    # @see Hash#<=>
    def <=> other
      if currencies.keys.length == 1 && other.currencies.length == 1
        if currencies.keys == other.currencies.keys
          return currencies.values.first <=> other.currencies.values.first
        end
      end

      currencies <=> other.currencies
    end

    # @return [true, false]
    # @see Object#respond_to?
    def respond_to? method_name, include_private = false
      super || currencies.respond_to?(method_name, include_private)
    end

    # @return [String]
    def inspect
      string = "#<#{self.class}"
      if currencies.any?
        string << " %s" % currencies.keys.sort.map { |code|
          value = currencies[code].to_s
          value.gsub!(/^(\d)$/, '0_0\1')
          value.gsub!(/^(\d{2})$/, '0_\1')
          value.gsub!(/(\d)(\d{2})$/, '\1_\2')
          value.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, '\1_')
          "#{code}: #{value}"
        }.join(', ')
      end
      string << '>'
    end
    alias to_s inspect

    protected

    attr_reader :currencies

    private

    def method_missing name, *args, &block
      if currencies.respond_to? name
        return currencies.send name, *args, &block
      elsif c = currencies[Recurly.default_currency] and c.respond_to? name
        if currencies.keys.length > 1
          raise TypeError, "can't convert multicurrency into Integer"
        else
          return c.send name, *args, &block
        end
      end

      super
    end
  end
end
