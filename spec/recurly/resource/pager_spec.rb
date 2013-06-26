require 'spec_helper'

describe Resource::Pager do
  let(:pager) { Resource::Pager.new resource }
  let(:resource) { Class.new(Resource) { def self.name() 'Resource' end } }

  describe "an instance" do
    it "must instantiate" do
      pager.must_be_instance_of Resource::Pager
    end

    it "must return an enumerator when no block is given" do
      pager.each.must_be_instance_of(
        defined?(Enumerator) ? Enumerator : Enumerable::Enumerator
      )
    end

    it "must iterate over a page" do
      stub_api_request(:get, 'resources') { XML[200][:index] }
      records = pager.each_current_page { |r|
        r.must_be_instance_of pager.resource_class
      }
      records.must_be_instance_of Array
      records.size.must_equal 2
    end

    it "must iterate across pages" do
      stub_api_request(:get, 'resources') { XML[200][:index][0] }
      stub_api_request(:get, 'resources?cursor=1234567890&per_page=2') {
        XML[200][:index][1]
      }
      pager.each { |r| r.must_be_instance_of pager.resource_class }
    end

    it "must yield all records across pages" do
      stub_api_request(:get, 'resources') { XML[200][:index][0] }
      stub_api_request(:get, 'resources?cursor=1234567890&per_page=2') {
        XML[200][:index][1]
      }
      i=0
      pager.each { |r| i += 1 }
      i.must_equal 3
    end

    describe "#find_each" do
      it "must restart from the beginning each time" do
        stub_api_request(:get, 'resources') { XML[200][:index][0] }
        stub_api_request(:get, 'resources?cursor=1234567890&per_page=2') {
          XML[200][:index][1]
        }
        count1 = 0
        count2 = 0
        pager.find_each { |r| count1 += 1 }
        pager.find_each { |r| count2 += 1 }
        count1.must_equal 3
        count2.must_equal count1
      end
    end

    describe "#count" do
      it "must fetch the count via HEAD" do
        stub_api_request(:head, 'resources') { XML[200][:index] }
        pager.count.must_equal 3
      end

      it "must not fetch the count when already loaded" do
        stub_api_request(:get, 'resources') { XML[200][:index] }
        pager.reload
        pager.count.must_equal 3
      end
    end

    describe "#links" do
      describe "page 1/2" do
        before do
          stub_api_request(:get, 'resources') { XML[200][:index][0] }
          pager.load!
        end

        it "must be tracked" do
          pager.links.wont_be_empty
        end

        describe "valid paging" do
          it "must go to the next page" do
            stub_api_request(:get, 'resources?per_page=2&cursor=1234567890') {
              XML[200][:index][1]
            }
            pager.next.wont_be_empty
          end
        end

        it "must return nil if the page is not available" do
          pager.start.must_be_nil
        end
      end

      describe "page 2/2" do
        before do
          stub_api_request(:get, 'resources') { XML[200][:index][1] }
          pager.load!
        end

        describe "valid paging" do
          it "must go to the first page" do
            stub_api_request(:get, 'resources?per_page=2') {
              XML[200][:index][0]
            }
            pager.start.wont_be_empty
          end
        end

        it "must return nil if the page is not available" do
          pager.next.must_be_nil
        end
      end
    end

    describe "building records" do
      let(:path) { 'resources/1/children' }

      before do
        pager.instance_variable_set :@uri, path
      end

      describe "#new" do
        it "must instantiate a new record with scoped path set" do
          child = pager.new :name => 'pagerino'
          child.must_be_instance_of resource
          stub_api_request(:post, path) { XML[201] }
          child.save
        end
      end

      describe "#create" do
        it "must create a new record through scoped path" do
          stub_api_request(:post, path) { XML[201] }
          child = pager.create :name => 'pagerina'
          child.must_be_instance_of resource
        end
      end

      describe "#create!" do
        it "must create a new record through scoped path" do
          stub_api_request(:post, path) { XML[201] }
          child = pager.create! :name => 'pagerello'
          child.must_be_instance_of resource
        end

        it "must raise an exception when invalid" do
          stub_api_request(:post, path) { XML[422] }
          proc {
            pager.create! :name => 'pagerella'
          }.must_raise Resource::Invalid
        end
      end
    end

    describe "#method_missing" do
      it "must build scopes" do
        resource.scope :active, :active => true
        active = pager.active
        active.must_be_instance_of Resource::Pager
        stub_api_request(:get, 'resources?active=true') { <<XML }
HTTP/1.1 200 OK

<resources type="array"/>
XML
        active.load!
      end
    end
  end
end
