# this overrides methods of Recurly::Resource relating to retrieval and storage of records. 
# it overrides all HTTP interactions and instead stores and retrieves records from memory. 
# this is very useful for application testing when interaction with recurly is undesirable.

module Recurly
  @in_memory_storage = false
  class << self
    attr_accessor :in_memory_storage
    alias_method :in_memory_storage?, :in_memory_storage

    def with_in_memory_storage(&block)
      self.in_memory_storage = true
      begin
        yield
      ensure
        self.in_memory_storage = false
      end
    end
  end

  class Resource
    # param_name is a thing which recurly purports to use (see Recurly::Resource#to_param) but never actually sets up 
    class << self
      attr_accessor :param_name
    end
    Recurly::Account.param_name = 'account_code'
    Recurly::AddOn.param_name = 'add_on_code'
    Recurly::Adjustment.param_name = 'uuid'
    Recurly::Coupon.param_name = 'coupon_code'
    Recurly::Invoice.param_name = 'invoice_number'
    Recurly::Plan.param_name = 'plan_code'
    Recurly::Subscription.param_name = 'uuid'
    #billing info is weird. it goes by account code of the associated account but there's no actual param on the class. we'll go by account.
    Recurly::BillingInfo.param_name = 'account'

    class << self
      # set an instance variable on the class where records will be stored
      def initialize_storage
        @records = {}
        @records_write_lock = Mutex.new
      end
    end

    # for each including class that's already defined, set up storage on the class 
    ObjectSpace.each_object(Class).select {|klass| klass <= Recurly::Resource }.each do |klass|
      klass.initialize_storage
    end

    # get storage set up for any future inheriting class 
    def self.inherited(inheriting_class)
      inheriting_class.initialize_storage
    end

    # redefine how associations work in-memory. @attributes will hold either a param_name, or array of 
    # param_names in the case of a has_many, and @reflections will hold records (instances of a subclass of 
    # Resource). 
    class << self
      alias orig_belongs_to belongs_to unless method_defined?(:orig_belongs_to)
      def belongs_to(assoc_name, options={})
        orig_belongs_to(assoc_name, options)
        # uniq to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:belongs_to] = associations[:belongs_to].uniq

        # defines a setter for the association. accepts either a record (instance of a subclass of Resource), 
        # or a string corresponding to the class's param_name, from which a record will be looked up. 
        associations_helper.send(:define_method, "#{assoc_name}=") do |assoc_record|
          if Recurly.in_memory_storage?
            assoc_record = record_for_association(assoc_name, assoc_record)
            reflections[assoc_name] = assoc_record
            @attributes[assoc_name] = assoc_record.to_param
          else
            self[assoc_name] = assoc_record
          end
        end

        # defines a getter for the association. the record is found by the param_name stored in 
        # @attributes[assoc_name]. 
        associations_helper.send(:define_method, assoc_name) do
          if @attributes[assoc_name]
            reflections[assoc_name] ||= Recurly.const_get(Helper.classify(member_name)).find(@attributes[assoc_name])
          else
            read_attribute(assoc_name)
          end
        end
      end

      alias orig_has_one has_one unless method_defined?(:orig_has_one)
      def has_one(assoc_name, options = {})
        orig_has_one(assoc_name, options)
        # uniq to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:has_one] = associations[:has_one].uniq

        # defines a setter for the association. accepts either a record (instance of a subclass of Resource), 
        # or a string corresponding to the class's param_name, from which a record will be looked up. 
        #
        # this one is exactly the same as belongs_to 
        associations_helper.send(:define_method, "#{assoc_name}=") do |assoc_record|
          if Recurly.in_memory_storage?
            assoc_record = record_for_association(assoc_name, assoc_record)
            reflections[assoc_name] = assoc_record
            @attributes[assoc_name] = assoc_record.to_param
          else
            self[assoc_name] = assoc_record
          end
        end

        # defines a getter for the association. the record is found by the param_name stored in 
        # @attributes[assoc_name].
        associations_helper.send(:define_method, assoc_name) do
          if @attributes[assoc_name]
            reflections[assoc_name] ||= Recurly.const_get(Helper.classify(assoc_name)).find(@attributes[assoc_name])
          else
            read_attribute(assoc_name)
          end
        end

        # build not implemented
        associations_helper.send(:define_method, "build_#{assoc_name}") do |*args|
          raise NotImplementedErrer
        end

        # create not implemented
        associations_helper.send(:define_method, "create_#{assoc_name}") do |*args|
          raise NotImplementedErrer
        end
      end

      alias orig_has_many has_many unless method_defined?(:orig_has_many)
      def has_many(collection_name, options = {})
        orig_has_many(collection_name, options)
        # uniq to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:has_many] = associations[:has_many].uniq

        # defines a setter for the association. accepts an array, in which each element may be either a record 
        # (instance of a subclass of Resource), or a string corresponding to the class's param_name, from which 
        # a record will be looked up. 
        associations_helper.send(:define_method, "#{collection_name}=") do |assoc_records|
          if Recurly.in_memory_storage?
            assoc_records = assoc_records.map do |record|
              record_for_association(Helper.singularize(collection_name), record)
            end
            reflections[collection_name] = assoc_records
            @attributes[collection_name] = assoc_records.map{|assoc_record| assoc_record.to_param }
          else
            self[collection_name] = assoc_records
          end
        end

        # defines a getter for the association. each record is found by the param_name stored in @attributes[assoc_name].
        # if that attribute does not exist, an empty array is returned. 
        associations_helper.send(:define_method, collection_name) do
          @attributes[collection_name] ||= []
          reflections[collection_name] ||= @attributes[collection_name].map do |id|
            record_for_association(Helper.singularize(collection_name), id)
          end.freeze
        end
      end
    end

    # redefine any existing associations so that the above applies rather than the original setter/getters 
    ObjectSpace.each_object(Class).select {|klass| klass <= Recurly::Resource }.each do |klass|
      klass.associations.each do |assoc_type, assoc_names|
        assoc_names.each do |assoc_name|
          klass.send(assoc_type, assoc_name)
        end
      end
    end

    module InMemoryClassMethods
      # locks for writing. anything that writes to @records should use this. 
      # yields the private @records structure which is to be modified.
      def record_write_locking
        @records_write_lock.synchronize do
          yield @records
        end
      end
      private :record_write_locking

      # finds a record by URI or by the param_name of this class (usually uuid) 
      def find(uuid, options = {})
        if uuid.nil?
          # Should we raise an ArgumentError, instead?
          raise NotFound, "can't find a record with nil identifier"
        end

        uri = uuid =~ /^http/ ? uuid : member_path(uuid)
        attributes = @records[uri] || raise(NotFound, "No #{self.name} found with uuid = #{uuid}")
        from_storage(attributes)
      end

      def all
        @records.map do |key, attributes|
          from_storage(attributes)
        end.freeze
      end

      def from_storage(attributes)
        new(attributes) { |record| record.persist! }
      end
    end

    module InMemoryInstanceMethods
      def save
        if true # this conditional is where I would check if the record is valid, but we have no validations, they are all server side ...
          self.send("#{self.class.param_name}=", UUIDTools::UUID.random_create.to_s) unless to_param

          self.class.send(:record_write_locking) do |records|
            records[storage_key] = self.attributes.dup
          end
          true
        else
          false
        end
      end

      def destroy
        return false unless persisted?
        key = self.class.member_path(self[self.class.param_name])
        self.class.send(:record_write_locking) do |records|
          records.delete(storage_key)
        end
        @destroyed = true
      end

      private
      def reflections
        @reflections ||= {}
      end

      # storage key for in-memory storage. this is the URI, the member_path for this class 
      def storage_key
        self.class.member_path(self[self.class.param_name])
      end

      def record_for_association(assoc_name, assoc_record)
        if Recurly.in_memory_storage?
          case assoc_record
          when Resource
            assoc_record
          when String
            Recurly.const_get(Helper.classify(assoc_name)).find(assoc_record)
          else
            fetch_association(assoc_name, assoc_record)
          end
        else
          self[assoc_name]
        end
      end
    end

    class Pager
      module InMemoryClassMethods
        def find(uuid)
          resource_class.find(uuid)
        end
      end

      module InMemoryInstanceMethods
        def count
          raise NotImplementedError
          # need to deal with scopes, or this would be right 
          #@resource_class.instance_eval { @records.size }
        end

        def load_from(uri, params)
          raise NotImplementedError, "Recurly::Pager#load_from"
        end
      end
    end
  end
end

require 'recurly/resource'
require 'recurly/resource/pager'

# perform some magic so that when Recurly.in_memory_storage is set, the methods from the InMemory modules above
# will be used; when Recurly.in_memory_storage is unset, the normal recurly methods will be used. 

classes_to_extend = {
  Recurly::Resource::InMemoryClassMethods => (class << ::Recurly::Resource; self; end),
  Recurly::Resource::InMemoryInstanceMethods => ::Recurly::Resource,
  Recurly::Resource::Pager::InMemoryClassMethods => (class << ::Recurly::Resource::Pager; self; end),
  Recurly::Resource::Pager::InMemoryInstanceMethods => ::Recurly::Resource::Pager,
}
classes_to_extend.each do |in_memory_module, klass|
  # save the original methods from the class to be called when in-memory is not in use. have to copy 
  # a reference to these methods before we include the in-memory methods module into klass. 
  original_methods = in_memory_module.instance_methods.map do |method_name|
    {method_name => klass.instance_method(method_name)} if klass.instance_methods.include?(method_name)
  end.compact.inject({}, &:update)

  # ruby 1.x will not bind a module's instance method to a class that does not include that module. in ruby 2
  # this line is not needed. 
  klass.send(:include, in_memory_module)

  in_memory_module.instance_methods.each do |method_name|
    in_memory_method = in_memory_module.instance_method(method_name)
    klass.send(:define_method, method_name) do |*args, &block|
      # make which method is invoked switch based on whether Recurly.in_memory_storage is set
      if ::Recurly.in_memory_storage?
        switched_method = in_memory_method
      else
        if original_methods[method_name]
          switched_method = original_methods[method_name]
        else
          raise RuntimeError, "method #{method_name} is only used with in-memory storage mode; Recurly client is currently using real recurly records"
        end
      end
      switched_method.bind(self).call(*args, &block)
    end
  end
end

class Recurly::Subscription
  def cancel
    self.state = 'canceled'
    now = Time.now
    self.canceled_at = now
    # just pick something in the future for expiry, I guess
    self.expires_at = now + 1.week
    save!
  end

  def terminate(refund_type = :none)
    unless REFUND_TYPES.include?(refund_type.to_s)
      raise(ArgumentError, "refund must be one of: #{REFUND_TYPES.join(', ')}")
    end
    self.state = 'expired'
    now = Time.now
    self.canceled_at = now
    self.expires_at = now
    save!
  end
  alias destroy terminate

  def reactivate
    raise NotImplementedError
  end

  def postpone(next_renewal_date)
    raise NotImplementedError
  end
end
