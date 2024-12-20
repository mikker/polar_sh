require "spec_helper"

module Polar
  RSpec.describe CustomerSession do
    describe ".create" do
      it "creates a customer", :vcr do
        customer_session = Polar::CustomerSession.create(
          customer_id: "866f8b85-a39a-4b57-9f62-fbf2fb9d16c7"
        )

        expect(customer_session).to(be_a(Polar::CustomerSession))
        expect(customer_session.customer["name"]).to(eq("Test Customer"))
      end
    end
  end
end
