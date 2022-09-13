require "spec_helper"

RSpec.describe Recurly::Webhooks do
  describe "verify_signature" do
    let(:secret) { "354fab5bd35f5a0d50845ee7e30165244468b13c2c343f104e4e730a59326d9d" }
    let(:body) { '{"id":"rjxwmwedwqug","object_type":"account","site_id":"qc326l1hl8k9","event_type":"created","event_time":"2022-09-13T21:18:40Z","account_code":"adfas23zzz14123"}' }
    let(:timestamp) { (Time.now.to_f * 1000).to_i }
    let(:signature) { OpenSSL::HMAC.hexdigest("sha256", secret, "#{timestamp}.#{body}") }
    let(:header) { "#{timestamp},#{signature}" }

    context "with current notification" do
      it "raises no error" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body) }.
          not_to raise_error
      end

      it "raises error if secrets mismatched" do
        expect { Recurly::Webhooks.verify_signature(header, "key", body) }.
          to raise_error(Recurly::Errors::SignatureVerificationError, /matching signature/)
      end

      it "raises error if payload body is altered" do
        expect { Recurly::Webhooks.verify_signature(header, secret, "{}") }.
          to raise_error(Recurly::Errors::SignatureVerificationError, /matching signature/)
      end

      it "raises error if header timestamp is altered" do
        altered_ts = ((Time.now + 1).to_f * 1000).to_i

        expect { Recurly::Webhooks.verify_signature("#{altered_ts},#{signature}", secret, body) }.
          to raise_error(Recurly::Errors::SignatureVerificationError, /matching signature/)
      end
    end

    context "with notification older than five minutes" do
      let(:header) { "1663103925004,ad24699f3beaa24c9af2cc7ada3ce4c835da0090194241b9d3add83d27f14bc3" }

      it "raises by default" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body) }.
          to raise_error(Recurly::Errors::SignatureVerificationError, /out of date/)
      end

      it "raises no error when tolerance is large enough" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body, tolerance: Float::INFINITY) }.
          not_to raise_error
      end
    end

    context "with multiple signatures in header" do
      let(:header) { "#{timestamp},de1ec7ab1e,#{signature}" }

      it "raises no error" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body) }.
          not_to raise_error
      end
    end

    context "malformed timestamp header" do
      let(:header) { "abc,#{signature}" }

      it "raises" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body) }.
          to raise_error(ArgumentError)
      end
    end

    context "no signatures in header" do
      let(:header) { "#{timestamp}," }

      it "raises" do
        expect { Recurly::Webhooks.verify_signature(header, secret, body) }.
          to raise_error(Recurly::Errors::SignatureVerificationError)
      end
    end
  end
end
