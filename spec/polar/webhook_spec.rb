require "spec_helper"

RSpec.describe Polar::Webhook do
  # Base64 encoded "secret"
  let(:webhook_secret) { "c2VjcmV0" }
  let(:raw_payload) { "{\"type\":\"test\"}" }

  let(:headers) do
    {
      "webhook-id" => "123",
      "webhook-timestamp" => Time.now.to_i.to_s,
      "webhook-signature" => "dummy-signature"
    }
  end

  let(:request) do
    double(
      raw_post: raw_payload,
      headers: headers
    )
  end

  before do
    allow(Polar.config).to(receive(:webhook_secret).and_return(webhook_secret))
  end

  describe "#initialize" do
    it "uses the configured secret when none is provided" do
      expect(described_class.new(request).secret).to(eq(Base64.encode64(webhook_secret)))
      expect(described_class.new(request, secret: "abc").secret).to(eq(Base64.encode64("abc")))
    end
  end

  describe "#event" do
    it "returns the event type" do
      expect(described_class.new(request).event["type"]).to(eq("test"))
    end
  end

  describe "#verify" do
    it "returns true if the event is valid" do
      allow(StandardWebhooks::Webhook).to(receive(:new)).and_return(double(verify: JSON.parse(raw_payload)))
      expect(described_class.new(request).verify).to(eq("type" => "test"))
    end

    it "returns false if the event is invalid" do
      allow(StandardWebhooks::Webhook).to(receive(:new)).and_raise(
        StandardWebhooks::StandardWebhooksError.new("Invalid")
      )
      expect { described_class.new(request).verify }.to(raise_error(StandardWebhooks::StandardWebhooksError))
    end

    context("with different resource types") do
      let(:webhook) { StandardWebhooks::Webhook.new(webhook_secret) }
      let(:mock_data) { {"id" => "123"} }

      before do
        allow(StandardWebhooks::Webhook).to(receive(:new)).and_return(
          double(verify: {"type" => resource_type, "data" => mock_data})
        )
      end

      {
        "checkout.created" => Polar::Checkout::Custom,
        "order.created" => Polar::Order,
        "product.created" => Polar::Product,
        "organization.created" => Polar::Organization,
        "subscription.created" => Polar::Subscription,
        "refund.created" => Polar::Refund,
        "benefit.created" => Polar::Benefit
      }.each do |type, klass|
        context("when type is #{type}") do
          let(:resource_type) { type }

          it "handles the #{type} event" do
            result = described_class.new(request).verify
            expect(result[:type]).to(eq(type))
            expect(result[:data]).to(eq(mock_data))
            expect(result[:object]).to(be_a(klass))
          end
        end
      end
    end
  end
end
