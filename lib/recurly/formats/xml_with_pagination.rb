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
        results = data.values.select{|v| v.is_a?(Array)}.first

        # use a singleton methods for now (maybe wrap in WillPaginate later?)
        total_entries = data["total_entries"] || 0
        def results.total_entries; total_entries; end

        current_page = data["current_page"] || 1
        def results.current_page; current_page; end

        per_page = data["per_page"]
        if per_page
          def results.per_page; per_page; end
        end

        results
      end
    end
  end
end

