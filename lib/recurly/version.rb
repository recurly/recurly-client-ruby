module Recurly
  module Version
    MAJOR   = 2
    MINOR   = 17
    PATCH   = 11
    PRE     = nil

    VERSION = [MAJOR, MINOR, PATCH, PRE].compact.join('.').freeze

    class << self
      def inspect
        VERSION.dup
      end
      alias to_s inspect
    end
  end
end
