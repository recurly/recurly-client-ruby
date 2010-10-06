module Recurly
  module Formats
    class XmlWithPaginationFormat
      include ActiveResource::Formats::XmlFormat

      def decode(xml)
        data = super

        if data.is_a?(Hash) and data["type"] == "collection" and data["current_page"]
          data = paginate_data(data)
        end

        data
      end

      # convert the data into a paginated resultset (array with singleton methods)
      def paginate_data(data)

        # find the first array and use that as the resultset (lame workaround)
        results = data.values.select{|v| v.is_a?(Array)}.first || []

        # define total_entries accessor on result object
        total_entries = data["total_entries"] || 0
        results.instance_eval "def total_entries; #{total_entries.to_i}; end"

        # define current_page accessor on result object
        current_page = data["current_page"] || 0
        results.instance_eval "def current_page; #{current_page.to_i}; end"

        # define per_page accessor on result object
        per_page = data["per_page"] || 0
        results.instance_eval "def per_page; #{per_page.to_i}; end"

        results
      end
    end
  end
end

