module Recurly
  module Version
    VERSION = "2.18.32"

    class << self
      def inspect
        VERSION.dup
      end
      alias to_s inspect
    end
  end
end
