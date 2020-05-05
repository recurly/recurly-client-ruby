require 'spec_helper'

describe ConnectionPool do
  subject { ConnectionPool.new }
  
  describe "when pool is empty" do
    it "must create a connection" do
      http = subject.with_connection { |h| h.start && h }
      http.started?.must_equal true
    end
  end

  describe "when pool has at least one started connection" do
    # start one connection and get the http object
    let(:http) { subject.with_connection { |h| h.start && h } }

    it "must re-use the connection if it's available" do
      # make sure it's started
      http
      http2 = subject.with_connection { |h| h }
      # they should be the same connection
      http.must_equal http2
    end

    it "must make a new connection if it's not available" do
      # start it
      subject.with_connection do |http1|
        # http1 is checked out, so a new http2 should be created
        subject.with_connection do |http2|
          # they should not be the same connection
          (http1 == http2).must_equal false
        end
      end
    end
  end

  describe "when checked out connection fails to start" do
    it "must not check it back into the pool" do
      # we have intentially not started this http object in the block
      http1 = subject.with_connection { |h| h }
      # we are starting this second one
      http2 = subject.with_connection { |h| h.start && h }
      # these should be different objects
      (http1 == http2).must_equal false

      # if we ask for another one
      http3 = subject.with_connection { |h| h }
      # it should have reused http2
      http2.must_equal http3
    end

    it "must make a new connection if it's not available" do
      # start it
      subject.with_connection do |http1|
        # http1 is checked out, so a new http2 should be created
        subject.with_connection do |http2|
          # they should not be the same connection
          (http1 == http2).must_equal false
        end
      end
    end
  end
end
