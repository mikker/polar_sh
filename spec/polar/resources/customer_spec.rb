require "spec_helper"

module Polar
  RSpec.describe Customer do
    describe ".list" do
      it "returns a customer list", :vcr do
        customers = Polar::Customer.list

        expect(customers).to(be_a(Array))
        expect(customers.first).to(be_a(Polar::Customer))
      end
    end

    describe ".create" do
      it "creates a customer", :vcr do
        customer = Polar::Customer.create(
          email: random_email,
          name: "Test Customer",
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        expect(customer).to(be_a(Polar::Customer))
        expect(customer.name).to(eq("Test Customer"))

        # clean-up
        Polar::Customer.delete(customer.id)
      end
    end

    describe ".get" do
      it "returns a customer", :vcr do
        customer = Polar::Customer.get("866f8b85-a39a-4b57-9f62-fbf2fb9d16c7")

        expect(customer).to(be_a(Polar::Customer))
        expect(customer.name).to(eq("Test Customer"))
      end
    end

    describe ".update" do
      it "updates a customer", :vcr do
        customer = Polar::Customer.update("866f8b85-a39a-4b57-9f62-fbf2fb9d16c7", {name: "Updated Customer"})
        expect(customer.name).to(eq("Updated Customer"))

        # reset
        Polar::Customer.update("866f8b85-a39a-4b57-9f62-fbf2fb9d16c7", {name: "Test Customer"})
      end
    end

    describe ".delete" do
      it "deletes a customer", :vcr do
        customer = Polar::Customer.create(
          name: "Test Customer",
          email: random_email,
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        id = customer.id

        Polar::Customer.delete(id)

        expect { Polar::Customer.get(id) }.to raise_error(Polar::Error)
      end
    end

    private

    def random_email
      "test-customer-#{SecureRandom.uuid}@polar.sh"
    end
  end
end
