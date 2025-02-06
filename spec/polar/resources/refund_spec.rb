require "spec_helper"

module Polar
  RSpec.xdescribe(Refund) do
    describe ".list" do
      it "returns a refund list", :vcr do
        refunds = Polar::Refund.list

        expect(refunds).to(be_a(Array))
        expect(refunds.first).to(be_a(Polar::Refund))
      end

      it "takes params", :vcr do
        refunds = Polar::Refund.list(query: "xyz")

        expect(refunds).to(be_a(Array))
        expect(refunds.length).to be(0)
      end
    end

    describe ".create" do
      it "creates a refund", :vcr do
        refund = Polar::Refund.create(
          order_id: "ed45370a-0425-43ef-9262-5579e81460b8",
          amount: 100_00,
          reason: "customer_requested"
        )

        expect(refund).to(be_a(Polar::Refund))
        expect(refund.amount).to(eq(100_00))
      end
    end
  end
end

