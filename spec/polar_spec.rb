require "spec_helper"

RSpec.describe Polar do
  describe ".configure" do
    it "yields the configuration" do
      Polar.configure do |config|
        expect(config).to(be_a(Polar::Configuration))

        config.access_token = "123"
      end

      expect(Polar.config.access_token).to(eq("123"))
    end

    it "can use sandbox" do
      expect(Polar.config.endpoint).to(eq("https://sandbox-api.polar.sh"))

      Polar.configure do |config|
        config.sandbox = false
      end

      expect(Polar.config.endpoint).to(eq("https://api.polar.sh"))
    ensure
      Polar.configure do |config|
        config.sandbox = true
      end
    end
  end
end
