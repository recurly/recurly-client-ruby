require 'recurly'
require 'pickle'

module Recurly
  class Resource
    module PickleAdapter
      include ::Pickle::Adapter::Base

      # Gets a list of the available models for this adapter
      def self.model_classes
        # since pickle's capture regexps are cached, we want all the models to loaded when this method is called. 
        # the black dog runs at night.
        # this just invokes autoload on all the resource classes. 
        # TODO find a more dynamic way to load these maybe. this is a complete list at the moment, I think, but for 
        # better maintainability the return value isn't just an array of these; it's dynamic. 
        Recurly::Account
        Recurly::AddOn
        Recurly::Adjustment
        Recurly::BillingInfo
        Recurly::Coupon
        Recurly::Invoice
        Recurly::Plan
        Recurly::Redemption
        Recurly::Subscription
        Recurly::SubscriptionAddOn
        Recurly::Transaction
        # now that everything is loaded select classes what inherit from Resource 
        ObjectSpace.each_object(Class).select { |klass| klass < ::Recurly::Resource }
      end

      # get a list of column names for a given class
      def self.column_names(klass)
        klass.attribute_names + klass.associations.values.inject([], &:|)
      end

      # Get an instance by id of the model
      def self.get_model(klass, id)
        klass.find(id)
      end

      # Find the first instance matching conditions
      def self.find_first_model(klass, conditions)
        if conditions && conditions.any?
          # TODO
          raise NotImplementedError, "don't know how to limit by conditions: #{conditions.inspect}"
        else
          # TODO don't load all
          klass.all.first
        end
      end

      # Find all models matching conditions
      def self.find_all_models(klass, conditions)
        if conditions && conditions.any?
          # TODO
          raise NotImplementedError, "don't know how to limit by conditions: #{conditions.inspect}"
        else
          klass.all
        end
      end

      # Create a model using attributes
      def self.create_model(klass, attributes)
        converted_attributes = attributes.map do |(name, value)|
          converted_value = name =~ /_at$/ && value.is_a?(String) ? Time.parse(value) : value
          {name => converted_value}
        end.inject({}, &:update)
        klass.send(:create!, converted_attributes)
      end
    end
  end
end
