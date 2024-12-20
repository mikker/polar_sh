require "spec_helper"

module Polar
  RSpec.describe LicenseKey do
    describe ".list" do
      it "returns a license_key list", :vcr do
        license_keys = Polar::LicenseKey.list

        expect(license_keys).to(be_a(Array))
        expect(license_keys.first).to(be_a(Polar::LicenseKey))
      end
    end

    describe ".get" do
      it "returns a license_key", :vcr do
        license_key = Polar::LicenseKey.get("19fb4c80-359e-4321-b0b0-df0a55df7f29")

        expect(license_key).to(be_a(Polar::LicenseKey))
        expect(license_key.display_key).to(eq("****-F6C647"))
      end
    end

    describe ".update" do
      it "updates a license_key", :vcr do
        license_key = Polar::LicenseKey.update("19fb4c80-359e-4321-b0b0-df0a55df7f29", {status: "revoked"})
        expect(license_key.status).to(eq("revoked"))

        # reset
        Polar::LicenseKey.update("19fb4c80-359e-4321-b0b0-df0a55df7f29", {status: "granted"})
      end
    end

    # Not sure how to create an activation
    xdescribe(".get_activation") do
      it "returns a license_key", :vcr do
        license_key = Polar::LicenseKey.get_activation("19fb4c80-359e-4321-b0b0-df0a55df7f29", "x")

        expect(license_key).to(be_a(Polar::LicenseKey))
        expect(license_key.name).to(eq("Test LicenseKey"))
      end
    end
  end
end
