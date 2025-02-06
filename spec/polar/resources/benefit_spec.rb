require "spec_helper"

module Polar
  RSpec.xdescribe(Benefit) do
    describe ".list" do
      it "returns a benefit list", :vcr do
        benefits = Polar::Benefit.list

        expect(benefits).to(be_a(Array))
        expect(benefits.first).to(be_a(Polar::Benefit))
      end

      it "takes params", :vcr do
        benefits = Polar::Benefit.list(query: "xyz")

        expect(benefits).to(be_a(Array))
        expect(benefits.length).to be(0)
      end
    end

    describe ".create" do
      it "creates a benefit", :vcr do
        benefit = Polar::Benefit.create(
          name: "Test Benefit",
          type: "repository",
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        expect(benefit).to(be_a(Polar::Benefit))
        expect(benefit.name).to(eq("Test Benefit"))
      end
    end

    describe ".get" do
      it "returns a benefit", :vcr do
        benefit = Polar::Benefit.get("ed45370a-0425-43ef-9262-5579e81460b8")

        expect(benefit).to(be_a(Polar::Benefit))
        expect(benefit.name).to(eq("Test Benefit"))
      end
    end

    describe ".update" do
      it "updates a benefit", :vcr do
        benefit = Polar::Benefit.update(
          "ed45370a-0425-43ef-9262-5579e81460b8",
          {name: "Updated Benefit"}
        )
        expect(benefit.name).to(eq("Updated Benefit"))

        # reset
        Polar::Benefit.update(
          "ed45370a-0425-43ef-9262-5579e81460b8",
          {name: "Test Benefit"}
        )
      end
    end

    describe ".delete" do
      it "deletes a benefit", :vcr do
        benefit = Polar::Benefit.delete("ed45370a-0425-43ef-9262-5579e81460b8")
        expect(benefit.id).to(eq("ed45370a-0425-43ef-9262-5579e81460b8"))
      end
    end

    describe ".list_grants" do
      it "returns a grant list", :vcr do
        grants = Polar::Benefit.list_grants("ed45370a-0425-43ef-9262-5579e81460b8")

        expect(grants).to(be_a(Array))
      end
    end
  end
end

