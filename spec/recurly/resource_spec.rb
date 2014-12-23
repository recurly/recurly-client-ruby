require 'spec_helper'

describe Resource do
  let(:resource) {
    Class.new Resource do
      def self.name
        'Resource'
      end

      def to_param
        self[:uuid]
      end
    end
  }

  describe "names and paths" do
    it "must provide default names" do
      resource.resource_name.must_equal "Resource"
      resource.collection_name.must_equal "resources"
      resource.member_name.must_equal "resource"
    end

    it "must provide relative paths" do
      resource.collection_path.must_equal "resources"
      resource.member_path(nil).must_equal "resources"
      resource.member_path(1).must_equal "resources/1"
    end
  end

  describe "class methods" do
    describe ".define_attribute_methods" do
      it "must define attribute methods" do
        resource.define_attribute_methods(names = %w(charisma endurance))
        resource.attribute_names.must_equal names
        record = resource.new
        resource.attribute_names.each do |name|
          record.send(name).must_be_nil
          record.send("#{name}?").must_equal false
          record.send("#{name}=", amount = 100)
          record.send(name).must_equal amount
          record.send("#{name}?").must_equal true
        end
      end
    end

    describe ".paginate" do
      it "must return a pager" do
        pager = resource.paginate
        pager.must_be_instance_of Resource::Pager
        pager.resource_class.must_equal resource
      end
    end

    describe ".scopes" do
      it "must return a hash of scopes" do
        resource.scopes.must_be_instance_of Hash
      end
    end

    describe ".scope" do
      it "must define a named scope with options" do
        resource.scope :active, :active => true
        resource.scopes[:active].must_equal :active => true
        pager = resource.active
        pager.must_be_instance_of Resource::Pager
        stub_api_request(:get, 'resources?active=true') { <<XML }
HTTP/1.1 200 OK

<resources type="array"/>
XML
        pager.load!
      end
    end

    describe ".find" do
      it "must return a record that exists" do
        stub_api_request(:get, 'resources/spock') { XML[200][:show] }
        resource.find(:spock).must_be_instance_of resource
      end

      it "must raise an error if no record is found" do
        stub_api_request(:get, 'resources/khan') { XML[404] }
        proc { resource.find :khan }.must_raise Resource::NotFound
      end
    end

    describe ".create" do
      it "must return a saved record when valid" do
        stub_api_request(:post, 'resources') { XML[201] }
        record = resource.create
        record.must_be_instance_of resource
      end

      it "must return an unsaved record when invalid" do
        stub_api_request(:post, 'resources') { XML[422] }
        record = resource.create
        record.must_be_instance_of resource
      end
    end

    describe ".create!" do
      it "must return a saved record when valid" do
        stub_api_request(:post, 'resources') { XML[201] }
        record = resource.create!
        record.must_be_instance_of resource
      end

      it "must raise an exception when invalid" do
        stub_api_request(:post, 'resources') { XML[422] }
        proc { resource.create! }.must_raise Resource::Invalid
      end
    end

    describe ".from_xml" do
      it "must deserialize based on type" do
        begin
          record = resource.from_xml <<XML
<?xml version="1.0" encoding="UTF-8"?>
<resource href="https://api.recurly.com/v2/resources/1">
  <name>Arrested Development</name>
  <was_hilarious type="boolean">true</was_hilarious>
  <is_in_production type="boolean">false</is_in_production>
  <canceled_on type="date">2006-02-10</canceled_on>
  <first_aired_at type="datetime">2003-11-02T00:00:00+00:00</first_aired_at>
  <finale_ratings type="float">3.3</finale_ratings>
  <number_of_episodes type="integer">53</number_of_episodes>
  <movie type="nil"></movie>
  <seasons type="array">
    <season type="integer">1</season>
    <season type="integer">2</season>
    <season type="integer">3</season>
  </seasons>
  <never_gonna_happen>
    <season type="integer">4</season>
  </never_gonna_happen>
  <a name="renew" href="https://api.recurly.com/v2/resources/1/renew" method="put"/>
  <a name="cancel" href="https://api.recurly.com/v2/resources/1/cancel" method="delete"/>
</resource>
XML
          record.instance_variable_defined?(:@href).must_equal true
          record.uri.must_equal "https://api.recurly.com/v2/resources/1"
          record[:name].must_equal 'Arrested Development'
          record[:was_hilarious].must_equal true
          record[:is_in_production].must_equal false
          record[:canceled_on].must_equal Date.new(2006, 2, 10)
          record[:first_aired_at].must_equal DateTime.new(2003, 11, 2)
          record[:finale_ratings].must_equal 3.3
          record[:number_of_episodes].must_equal 53
          3.times { |n| record[:seasons][n].must_be_kind_of Integer }
          record[:never_gonna_happen]['season'].must_be_kind_of Integer
          stub_api_request(:put, 'resources/1/renew') { "HTTP/1.1 200\n" }
          record.follow_link :renew
          stub_api_request(:delete, 'resources/1/cancel') { "HTTP/1.1 422\n" }
          proc { record.follow_link :cancel }.must_raise API::UnprocessableEntity
        end
      end
    end

    describe ".associations" do
      it "must be empty without any associations defined" do
        resource.associations_for_relation(:has_many).must_be_empty
        resource.associations_for_relation(:has_one).must_be_empty
      end
    end

    describe ".has_many" do
      before do
        Recurly.const_set :Reason, Class.new(Resource)
        resource.has_many :reasons
      end

      after do
        Recurly.send :remove_const, :Reason
      end

      it "must define an association" do
        resource.associations_for_relation(:has_many).must_include 'reasons'
        resource.reflect_on_association(:reasons).must_equal :has_many
      end

      it "must return a pager for fresh records" do
        resource.new.reasons.must_be_kind_of Enumerable
      end
    end

    describe ".has_one and .belongs_to" do
      before do
        Recurly.const_set :Day, Class.new(Resource)
        resource.has_one :day
        Day.belongs_to :resource
      end

      after do
        Recurly.send :remove_const, :Day
      end

      it "must define an association" do
        resource.associations_for_relation(:has_one).must_include 'day'
        resource.reflect_on_association(:day).must_equal :has_one
        Day.associations_for_relation(:belongs_to).must_include 'resource'
        Day.reflect_on_association(:resource).must_equal :belongs_to
      end

      it "must return nil for new records" do
        resource.new.day.must_be_nil
      end

      it "must lazily fetch a record and assign a relation" do
        stub_api_request(:get, 'resources/1') { <<XML }
HTTP/1.1 200 OK

<?xml version="1.0" encoding="UTF-8"?>
<resource>
  <name>Stephen</name>
  <day href="https://api.recurly.com/v2/resources/1/day"/>
</resource>
XML
        record = resource.find "1"
        stub_api_request(:get, 'resources/1/day') { <<XML }
HTTP/1.1 200 OK

<?xml version="1.0" encoding="UTF-8"?>
<day>
  <resource href="http://api.recurly.com/v2/resources/1"/>
  <name>Monday</name>
</day>
XML
        record.day.must_be_instance_of Day
        record.day.resource.must_equal record
      end
    end

    describe ".has_one, readonly => false" do
      before do
        Recurly.const_set :Day, Class.new(Resource)
        resource.has_one :day, :readonly => false
        @record = resource.new
      end

      after do
        Recurly.send :remove_const, :Day
      end

      it "must assign relation from a Hash" do
        @record.day = {}
        @record.day.must_be_kind_of Day
      end
      it "must assign relation from an instance of the associated class" do
        @record.day = Day.new
        @record.day.must_be_kind_of Day
      end
      it "assigning relation from another class must raise an exception" do
        proc { @record.day = Class }.must_raise ArgumentError
      end
    end

    describe "#initialize" do
      let(:record) { resource.new :name => 'Gesundheit' }

      it "must instantiate" do
        record.must_be_instance_of resource
      end

      it "must return a new record" do
        record.new_record?.must_equal true
        record.persisted?.must_equal false
        record.destroyed?.must_equal false
      end

      it "must assign attributes" do
        record[:name].must_equal 'Gesundheit'
      end
    end
  end

  describe "instance methods" do
    let(:record) { resource.new }

    before do
      resource.define_attribute_methods [:name]
    end

    describe "#reload" do
      it "must raise an exception for new records" do
        proc { record.reload }.must_raise Resource::NotFound
      end

      it "must reload attributes for persistent records" do
        record[:uuid] = 'neo'
        stub_api_request(:get, 'resources/neo') { <<XML }
HTTP/1.1 200 OK

<resource>
  <uuid>neo</uuid>
  <name>The Matrix</name>
</resource>
XML
        record.reload
        record[:name].must_equal 'The Matrix'
      end
    end

    describe "#persisted?" do
      it "must return false for new records" do
        record.persisted?.must_equal false
      end

      it "must return true for persisted records" do
        record.instance_eval { @new_record = @destroyed = false }
        record.persisted?.must_equal true
      end

      it "must return false for destroyed records" do
        record.instance_eval { @new_record, @destroyed = false, true }
        record.persisted?.must_equal false
      end
    end

    describe "#read_attribute" do
      it "must read with string or symbol" do
        record.name = 'Hi'
        record[:name].must_equal 'Hi'
        record['name'].must_equal 'Hi'
      end
    end

    describe "#write_attribute" do
      it "must write with string or symbol" do
        record[:name] = 'What?'
        record.name.must_equal 'What?'
        record['name'] = 'Who?'
        record.name.must_equal 'Who?'
      end

      it "must track changed attributes" do
        record[:uuid] = 1
        record[:name] = 'William'
        record.persist!

        record.changed_attributes.must_be_empty
        record.name = 'Wendy'
        record.changed_attributes.key?('name').must_equal true
        record.changed.must_include 'name'
        record.changes.must_equal 'name' => %w(William Wendy)
        record.name_change.must_equal %w(William Wendy)
        record.name_changed?.must_equal true
        record.name_was.must_equal 'William'
        record.persist! true
        record.changed_attributes.must_be_empty
        record.previous_changes.must_equal 'name' => %w(William Wendy)
        record.name_previously_changed?.must_equal true
        record.name_previously_was.must_equal 'William'
      end
    end

    describe "#to_xml" do
      before do
        record[:uuid] = 'Eminem'
        record.persist!
        record[:name] = 'Slim Shady'
      end

      it "must only show deltas" do
        record.to_xml.must_equal "<resource><name>Slim Shady</name></resource>"
      end
    end

    describe "saving" do
      it "must post new records" do
        stub_api_request(:post, 'resources') { XML[201] }
        record.save!
      end

      it "must put persisted records" do
        def record.to_param() 1 end
        record.persist!
        record.name = 'Persistent Little Bug'
        stub_api_request(:put, 'resources/1') { XML[200][:update] }
        record.save!
      end

      describe "invalid records" do
        before do
          Recurly.const_set :Child, resource
          resource.has_one :child, :readonly => false
          record.child = resource.new
          stub_api_request(:post, 'resources') { XML[422] }
        end

        after do
          Recurly.send :remove_const, :Child
        end

        it "#save must return false and assign errors" do
          record.errors.empty?.must_equal true
          record.save.must_equal false
          record.errors[:name].wont_be_nil
          record.child.errors[:name].wont_be_nil
        end

        it "#save! must raise an exception" do
          proc { record.save! }.must_raise Resource::Invalid
        end
      end
    end

    describe "#errors" do
      it "must return a Hash for errors" do
        record.errors.must_be_kind_of Hash
      end
    end

    describe "#persist!" do
      before do
        record[:uuid] = 'snowflake'
      end

      it "must convert new records to persisted" do
        record.new_record?.must_equal true
        record.persisted?.must_equal false
        record.persist!.must_equal true
        record.new_record?.must_equal false
        record.persisted?.must_equal true
      end

      it "must clear previous changes" do
        record.name = 'Name'
        record.persist!.must_equal true
        record.changed_attributes.must_be_empty
      end
    end

    describe "#uri" do
      it "must return nil for a resource where persisted is false" do
        record.uri.must_be_nil
      end

      it "must return a URI for a resource where persisted is false" do
        def record.to_param() 1 end
        record.persist!
        record.uri.must_equal 'https://api.recurly.com/v2/resources/1'
      end
    end

    describe "#destroy" do
      it "must return false if a record does not persist" do
        record.destroy.must_equal false
      end

      it "must destroy a record that persists" do
        def record.to_param() 1 end
        record.persist!
        stub_api_request(:delete, 'resources/1') { XML[200][:destroy] }
        record.destroy.must_equal true
      end

      it "must raise an error if a persisted record is not found" do
        def record.to_param() 1 end
        record.persist!
        stub_api_request(:delete, 'resources/1') { XML[404] }
        proc { record.destroy }.must_raise Resource::NotFound
      end
    end

    describe "#valid?" do
      it "must return true if persisted without changes" do
        record.persist!
        record.valid?.must_equal true
      end

      it "must return true if not persisted without changes and no errors" do
        record.valid?.must_equal true
      end

      it "must return nil if persisted with changes" do
        record.persist!
        record[:uuid] = 'changed'
        record.valid?.must_equal nil
      end

      it "must return nil if not persisted with changes and no errors" do
        record[:uuid] = 'changed'
        record.valid?.must_equal nil
      end

      it "must return false if it has errors" do
        record.errors[:name] = 'an error'
        record.valid?.must_equal false
      end
    end

  end
end
