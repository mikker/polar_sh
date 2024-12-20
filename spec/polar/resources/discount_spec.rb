require "spec_helper"

module Polar
  RSpec.describe Discount do
    describe ".list" do
      it "returns a discount list", :vcr do
        discounts = Polar::Discount.list

        expect(discounts).to(be_a(Array))
        expect(discounts.first).to(be_a(Polar::Discount))
      end
    end

    describe ".create" do
      it "creates a discount", :vcr do
        discount = Polar::Discount.create(
          name: "Test Discount",
          duration: "forever",
          type: "percentage",
          basis_points: 100,
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        expect(discount).to(be_a(Polar::Discount))
        expect(discount.name).to(eq("Test Discount"))
      end
    end

    describe ".get" do
      it "returns a discount", :vcr do
        discount = Polar::Discount.get("6e62566b-946f-45d8-842c-7c60a6474005")

        expect(discount).to(be_a(Polar::Discount))
        expect(discount.name).to(eq("Test Discount"))
      end
    end

    describe ".update" do
      it "updates a discount", :vcr do
        discount = Polar::Discount.update("6e62566b-946f-45d8-842c-7c60a6474005", {name: "Updated Discount"})
        expect(discount.name).to(eq("Updated Discount"))

        # reset
        Polar::Discount.update("6e62566b-946f-45d8-842c-7c60a6474005", {name: "Test Discount"})
      end
    end

    describe ".delete" do
      it "deletes a discount", :vcr do
        discount = Polar::Discount.create(
          name: "Test Discount",
          duration: "forever",
          type: "percentage",
          basis_points: 100,
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        id = discount.id

        Polar::Discount.delete(id)

        expect { Polar::Discount.get(id) }.to raise_error(Polar::Error)
      end
    end
  end
end
