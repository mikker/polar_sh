require "spec_helper"

module Polar
  RSpec.describe Organization do
    describe ".list" do
      it "returns a organization list", :vcr do
        organizations = Polar::Organization.list

        expect(organizations).to(be_a(Array))
        expect(organizations.first).to(be_a(Polar::Organization))
      end

      it "takes params", :vcr do
        organizations = Polar::Organization.list(slug: "xyz")

        expect(organizations).to(be_a(Array))
        expect(organizations.length).to be(0)
      end
    end

    describe ".create" do
      it "creates a organization", :vcr do
        organization = Polar::Organization.create(
          name: "Test Organization",
          slug: "test-org-#{rand(100)}"
        )

        expect(organization).to(be_a(Polar::Organization))
        expect(organization.name).to(eq("Test Organization"))
      end
    end

    describe ".get" do
      it "returns a organization", :vcr do
        organization = Polar::Organization.get("e6b79af2-386f-4f34-901c-1078dcd2641f")

        expect(organization).to(be_a(Polar::Organization))
        expect(organization.name).to(eq("Brainbow-sandbox"))
      end
    end

    describe ".update" do
      it "updates a organization", :vcr do
        organization = Polar::Organization.update(
          "e6b79af2-386f-4f34-901c-1078dcd2641f",
          {name: "Updated Organization"}
        )
        expect(organization.name).to(eq("Updated Organization"))

        # reset
        Polar::Organization.update("e6b79af2-386f-4f34-901c-1078dcd2641f", {name: "Brainbow-sandbox"})
      end
    end
  end
end
