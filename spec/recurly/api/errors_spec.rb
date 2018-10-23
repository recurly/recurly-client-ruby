require 'spec_helper'

describe Recurly::API::ResponseError do
  describe "#xml" do
    let(:xml) { '<?xml version="1.0"?><root/>' }

    describe "when response not assigned" do
      let(:error) { Recurly::API::ResponseError.new nil, nil }

      it "must return nil" do
        error.send(:xml).must_equal nil
      end
    end

    describe "when response assigned" do
      let(:response) { MiniTest::Mock.new }
      let(:error) { Recurly::API::ResponseError.new nil, response }

      describe "when xml already cached" do
        before { error.instance_variable_set :@xml, xml }

        it "must return cached value" do
          error.send(:xml).must_equal xml
        end
      end

      describe "when response body is nil" do
        before { response.expect :body, nil }

        it "must return nil" do
          error.send(:xml).must_equal nil
        end
      end

      describe "when response body is empty string" do
        before { 2.times { response.expect :body, '' } }

        it "must return nil" do
          error.send(:xml).must_equal nil
        end
      end

      describe "when response body is xml" do
        before {  3.times { response.expect :body, xml } }

        it "must return instance of Recurly::XML" do
          error.send(:xml).must_be_instance_of Recurly::XML
        end
      end

      describe "when using response body is not valid XML" do
        let(:html) { "<html><body><hr></body></html>" }

        before { 3.times { response.expect :body, html } }

        it "must return nil" do
          error.send(:xml).must_equal nil
        end
      end
    end
  end
end
