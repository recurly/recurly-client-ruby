# this overrides methods of Recurly::Resource relating to retrieval and storage of records. 
# it overrides all HTTP interactions and instead stores and retrieves records from memory. 
# this is very useful for application testing when interaction with recurly is undesirable.

module Recurly
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

    # redefine how associations work. @attributes will hold either a param_name, or array of param_names in the 
    # case of a has_many, and @reflections will hold records (instances of a subclass of Resource). 
    class << self
      alias orig_belongs_to belongs_to unless method_defined?(:orig_belongs_to)
      def belongs_to(assoc_name, options={})
        orig_belongs_to(assoc_name, options)
        # make this a set to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:belongs_to] = associations[:belongs_to].to_set

        # defines a setter for the association. accepts either a record (instance of a subclass of Resource), or a string 
        # corresponding to the class's param_name, from which a record will be looked up. 
        associations_helper.send(:define_method, "#{assoc_name}=") do |assoc_record|
          assoc_record = case assoc_record
          when Resource
            assoc_record
          when String
            Recurly.const_get(Helper.classify(assoc_name)).find(assoc_record)
          else
            raise ArgumentError
          end
          reflections[assoc_name] = assoc_record
          @attributes[assoc_name] = assoc_record.to_param
        end

        # defines a getter for the association. the record is found by the param_name stored in @attributes[assoc_name].
        # if that attribute does not exist, nil is returned. 
        associations_helper.send(:define_method, assoc_name) do
          if @attributes[assoc_name]
            reflections[assoc_name] ||= Recurly.const_get(Helper.classify(member_name)).find(@attributes[assoc_name])
          else
            nil
          end
        end
      end

      alias orig_has_one has_one unless method_defined?(:orig_has_one)
      def has_one(assoc_name, options = {})
        orig_has_one(assoc_name, options)
        # make this a set to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:has_one] = associations[:has_one].to_set

        # defines a setter for the association. accepts either a record (instance of a subclass of Resource), or a string 
        # corresponding to the class's param_name, from which a record will be looked up. 
        #
        # this one is exactly the same as belongs_to 
        associations_helper.send(:define_method, "#{assoc_name}=") do |assoc_record|
          assoc_record = case assoc_record
          when Resource
            assoc_record
          when String
            Recurly.const_get(Helper.classify(assoc_name)).find(assoc_record)
          else
            raise ArgumentError
          end
          reflections[assoc_name] = assoc_record
          @attributes[assoc_name] = assoc_record.to_param
        end

        # defines a getter for the association. the record is found by the param_name stored in @attributes[assoc_name].
        # if that attribute does not exist, nil is returned. 
        associations_helper.send(:define_method, assoc_name) do
          if @attributes[assoc_name]
            reflections[assoc_name] ||= Recurly.const_get(Helper.classify(assoc_name)).find(@attributes[assoc_name])
          else
            nil
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
        # make this a set to avoid duplicates, since code below sets up associations which are already defined. 
        associations[:has_many] = associations[:has_many].to_set

        # defines a setter for the association. accepts an array, in which each element may be either a record 
        # (instance of a subclass of Resource), or a string corresponding to the class's param_name, from which 
        # a record will be looked up. 
        associations_helper.send(:define_method, "#{collection_name}=") do |assoc_records|
          assoc_records = assoc_records.map do |record|
            case record
            when Resource
              record
            when String
              Recurly.const_get(Helper.classify(collection_name)).find(record)
            else
              raise ArgumentError
            end
          end
          reflections[collection_name] = assoc_records
          @attributes[collection_name] = assoc_records.map{|assoc_record| assoc_record.to_param }
        end

        # defines a getter for the association. each record is found by the param_name stored in @attributes[assoc_name].
        # if that attribute does not exist, an empty array is returned. 
        associations_helper.send(:define_method, collection_name) do
          @attributes[collection_name] ||= []
          reflections[collection_name] ||= @attributes[collection_name].map{|id| Recurly.const_get(Helper.classify(member_name)).find(id) }.freeze
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

    class << self
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

    class Pager
      class << self
        def find(uuid)
          resource_class.find(uuid)
        end
      end

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
