module Recurly
  #
  # A special subclass of Array which allows
  # indexing by currency. Only works if the item
  # type response to `currency`.
  class CurrencyArray < Array
    def [](key)
      if key.is_a?(Symbol) || key.is_a?(String)
        key = key.to_s.upcase
        self.find { |c| c.currency.upcase == key }
      else
        super key
      end
    end
  end
end
