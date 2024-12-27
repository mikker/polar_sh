require "spec_helper"

module Polar
  RSpec.describe Order do
    describe ".list" do
      it "returns a order list", :vcr do
        orders = Polar::Order.list

        expect(orders).to(be_a(Array))
        expect(orders.first).to(be_a(Polar::Order))
      end
    end

    describe ".get" do
      it "returns a order", :vcr do
        order = Polar::Order.get("89154ef0-35d3-416d-ae7b-2f55bab1c6e5")

        expect(order).to(be_a(Polar::Order))
        expect(order.id).to(eq("89154ef0-35d3-416d-ae7b-2f55bab1c6e5"))
      end
    end

    # TODO: How to generate test data?
    xdescribe(".get_invoice") do
      it "returns an invoice", :vcr do
        invoice = Polar::Order.get_invoice("89154ef0-35d3-416d-ae7b-2f55bab1c6e5")

        expect(invoice).to(be_a(Polar::Invoice))
        expect(invoice.id).to(eq("89154ef0-35d3-416d-ae7b-2f55bab1c6e5"))
      end
    end
  end
end
