require "spec_helper"

module Polar
  RSpec.describe Client do
    describe ".headers" do
      around do |example|
        original = Polar.config.api_version
        example.run
        Polar.config.api_version = original
      end

      it "pins the API version by default" do
        expect(Client.headers[:polar_version]).to(eq(Configuration::DEFAULT_API_VERSION))
      end

      it "sends the configured API version" do
        Polar.config.api_version = "2026-10"
        expect(Client.headers[:polar_version]).to(eq("2026-10"))
      end

      it "omits the header when the API version is nil" do
        Polar.config.api_version = nil
        expect(Client.headers).not_to(have_key(:polar_version))
      end

      it "sends the version as a Polar-Version header" do
        headers = HTTP::Headers.coerce(Client.headers)
        expect(headers["Polar-Version"]).to(eq(Configuration::DEFAULT_API_VERSION))
      end
    end
  end
end
