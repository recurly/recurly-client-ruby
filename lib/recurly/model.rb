# frozen_string_literal: true

module Recurly
  # Base model class for Recurly ORM Interface.
  class Model
    API_KEYS = %i[ids limit sort order begin_time end_time].freeze
    attr_accessor :resource

    def initialize(res)
      @resource = res
    end

    def self.client
      cli = Config.client
      raise "API client is not configured" unless cli

      cli
    end

    def self.api_keys
      API_KEYS
    end

    # Lookup methods which should be implemented in subclasses.
    def self.list(params)
      raise NotImplementedError, "The list method should be implemented in the subclass."
    end

    def self.get(id:)
      raise NotImplementedError, "The get method should be implemented in the subclass."
    end

    # Lookup methods
    def self.all
      where
    end

    def self.where(query = query_params, *args)
      if query.is_a?(String)
        conditions = QueryParser.parse(query, *args)
        api_params = {}
        filter_params = []
        conditions.each do |cond|
          val = cond[:value].respond_to?(:iso8601) ? cond[:value].iso8601 : cond[:value]
          if api_keys.include?(cond[:key].to_sym)
            api_params[cond[:key].to_sym] = val
          else
            filter_params << cond.merge(value: val)
          end
        end
        pager = list(params: api_params)
        ModelPager.new(model_class: self, pager: pager, filters: filter_params)
      else
        api_params = (query || {}).select { |k, _| api_keys.include?(k) }
        pager = list(params: api_params)
        ModelPager.new(model_class: self, pager: pager)
      end
    end

    def self.find_by(args = {})
      args[:id] ? new(get(id: args[:id])) : nil
    rescue Recurly::Errors::NotFoundError
      nil
    end

    # Default query parameters for listing or searching models.
    def self.query_params(args = nil)
      params = { limit: 200 }
      if args
        params[:limit] = args[:limit] if args[:limit]
        params[:sort] = args[:sort] if args[:sort]
        params[:order] = args[:order] if args[:order]
        params[:begin_time] = args[:begin_time].iso8601 if args[:begin_time]
        params[:end_time] = args[:end_time].iso8601 if args[:end_time]
      end
      params
    end

    # Method delegation to the resource for all methods not defined in this or child classes.
    def method_missing(method, *args, &block)
      if @resource.respond_to?(method)
        @resource.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      @resource.respond_to?(method, include_private) || super
    end
  end
end
