# frozen_string_literal: true

module Recurly
  # Handles filtering logic for ModelPager
  class ModelFilter
    def initialize(filters)
      @filters = filters
    end

    def include?(model)
      return true if @filters.nil? || @filters.empty?

      @filters.all? do |cond|
        val = cond[:key].match(/\./) ? dig_value(model, cond[:key]) : model.public_send(cond[:key])
        cmp_val = cond[:value]

        val_parsed = try_parse(val)
        cmp_parsed = try_parse(cmp_val)

        case cond[:op]
        when "="
          val_parsed == cmp_parsed
        when "!="
          val_parsed != cmp_parsed
        when ">", ">=", "<", "<="
          return false if val_parsed.nil? || cmp_parsed.nil?

          case cond[:op]
          when ">"
            val_parsed > cmp_parsed
          when ">="
            val_parsed >= cmp_parsed
          when "<"
            val_parsed < cmp_parsed
          when "<="
            val_parsed <= cmp_parsed
          end
        else
          false
        end
      end
    end

    private

    # Recursively dig through nested attributes and arrays
    def dig_value(obj, key_chain)
      keys = key_chain.to_s.split(".")
      current = obj
      keys.each do |key|
        if current.is_a?(Array)
          current = current.map { |el| dig_value(el, key) }.flatten.compact
        elsif current.respond_to?(key)
          current = current.public_send(key)
        else
          return nil
        end
      end
      current.is_a?(Array) && current.size == 1 ? current.first : current
    end

    def try_parse(value)
      begin
        return DateTime.parse(value) if value.is_a?(String)
      rescue ArgumentError;       end
      begin
        return Integer(value) if value.to_s.match(/\A-?\d+\z/)
      rescue ArgumentError, TypeError;       end
      begin
        return Float(value) if value.to_s.match(/\A-?\d+(\.\d+)?\z/)
      rescue ArgumentError, TypeError;       end
      value
    end
  end
end
