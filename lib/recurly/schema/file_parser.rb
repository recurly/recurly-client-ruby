module Recurly
  # This is a wrapper class to help parse http response into Recurly objects.
  class FileParser

    # Parses the json body into a recurly object.
    #
    # @param body [String] The data string to cast.
    # @return [Resource]
    def self.parse(body)
      Recurly::Resources::BinaryFile.cast(data: body)
    end
  end
end
