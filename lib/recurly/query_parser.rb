# frozen_string_literal: true

module Recurly
  class QueryParser
    # Parses a SQL-like query string and arguments into a hash of conditions.
    # Example: "order = ? AND sort = ? AND state != ?", 'desc', 'updated_at', 'inactive'
    def self.parse(query, *args)
      conditions = []
      arg_index = 0
      raise ArgumentError, "Input too long" if query.length > 1000

      reg = /([a-zA-Z_][\w\.]*)\s*(=|!=|>=|<=|>|<)\s*(\?|'(?:[^']*)'|"(?:[^"]*)"|-?\d+(?:\.\d+)?|\w+)/i
      query.scan(reg).each do |key, op, val, _|
        if val == "?"
          value = args[arg_index]
          arg_index += 1
        else
          # Remove quotes if present
          value = val.gsub(/\A['"]|['"]\z/, "")
          # Convert numeric strings to numbers
          if value.match(/\A-?\d+\z/)
            value = value.to_i
          elsif value.match(/\A-?\d+\.\d+\z/)
            value = value.to_f
          end
        end
        conditions << { key: key, op: op, value: value }
      end

      conditions
    end
  end
end
