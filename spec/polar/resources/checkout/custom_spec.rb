require "spec_helper"

module Polar
  RSpec.describe Checkout::Custom do
    describe ".list" do
      it "returns a checkout list", :vcr do
        checkouts = Polar::Checkout::Custom.list

        expect(checkouts).to(be_a(Array))
        expect(checkouts.first).to(be_a(Polar::Checkout))
      end
    end

    describe ".create" do
      it "creates a checkout session", :vcr do
        checkout = Polar::Checkout::Custom.create(
          product_id: "ed45370a-0425-43ef-9262-5579e81460b8"
        )

        expect(checkout).to(be_a(Polar::Checkout))
        expect(checkout.product["name"]).to(eq("Test Product"))
      end
    end

    describe ".get" do
      it "returns a checkout", :vcr do
        checkout = Polar::Checkout::Custom.get("e1c6b126-4ebd-4797-ab16-8b559b2cfb9a")

        expect(checkout).to(be_a(Polar::Checkout))
        expect(checkout.product["name"]).to(eq("Test Product"))
      end
    end

    # TODO:
    # Doesn't seem to work. What params can be updated?
    xdescribe(".update") do
      it "updates a checkout", :vcr do
        checkout = Polar::Checkout::Custom.update(
          "e1c6b126-4ebd-4797-ab16-8b559b2cfb9a",
          {custom_field_data: {test: "Hi"}}
        )
        expect(checkout.custom_field_data).to(eq(test: "Hi"))

        # reset
        Polar::Checkout::Custom.update("e1c6b126-4ebd-4797-ab16-8b559b2cfb9a", {customer_name: nil})
      end
    end

    describe ".client_update" do
      it "creates a checkout session", :vcr do
        checkout = Polar::Checkout::Custom.client_update(
          "polar_c_Tta5TxPD4nMXtCHvHFHezBXoqK0Wq88jkPfiv2gTKaE",
          customer_name: "Updated"
        )

        expect(checkout).to(be_a(Polar::Checkout))
        expect(checkout.customer_name).to(eq("Updated"))

        Polar::Checkout::Custom.client_update(
          "polar_c_Tta5TxPD4nMXtCHvHFHezBXoqK0Wq88jkPfiv2gTKaE",
          customer_name: "Test Customer"
        )
      end
    end

    describe ".clent_get" do
      it "returns a checkout", :vcr do
        checkout = Polar::Checkout::Custom.client_get("polar_c_Tta5TxPD4nMXtCHvHFHezBXoqK0Wq88jkPfiv2gTKaE")

        expect(checkout).to(be_a(Polar::Checkout))
        expect(checkout.product["name"]).to(eq("Test Product"))
      end
    end

    # TODO:
    # Requires "higher level access token"
    # Is this an internal API only?
    xdescribe(".client_confirm") do
      it "returns a checkout", :vcr do
        checkout = Polar::Checkout::Custom.create(product_id: "ed45370a-0425-43ef-9262-5579e81460b8")
        checkout = Polar::Checkout::Custom.client_confirm(checkout.client_secret)
        expect(checkout).to(be_a(Polar::Checkout))
        expect(checkout.status).to(eq("confirmed"))
      end
    end
  end
end
