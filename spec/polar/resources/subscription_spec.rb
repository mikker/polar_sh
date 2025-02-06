# frozen_string_literal: true

require "spec_helper"

module Polar
  RSpec.xdescribe(Subscription) do
    # These are Cursor generated stubs for when we figure out how to generate test data
    describe ".list" do
      it "returns a subscription list", :vcr do
        subscriptions = Polar::Subscription.list

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.first).to(be_a(Polar::Subscription))
      end

      it "takes params", :vcr do
        subscriptions = Polar::Subscription.list(query: "xyz")

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.length).to be(0)
      end
    end

    describe ".export" do
      it "returns a subscription export list", :vcr do
        subscriptions = Polar::Subscription.export

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.first).to(be_a(Polar::Subscription))
      end

      it "takes params", :vcr do
        subscriptions = Polar::Subscription.export(query: "xyz")

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.length).to be(0)
      end
    end

    describe ".get" do
      it "returns a subscription", :vcr do
        subscription = Polar::Subscription.get("sub_01HNW7HXRN4WQRM5GDGPZ42K2N")

        expect(subscription).to(be_a(Polar::Subscription))
        expect(subscription.id).to(eq("sub_01HNW7HXRN4WQRM5GDGPZ42K2N"))
      end
    end

    describe ".update" do
      it "updates a subscription", :vcr do
        subscription = Polar::Subscription.update(
          "sub_01HNW7HXRN4WQRM5GDGPZ42K2N",
          {status: "active"}
        )
        expect(subscription.status).to(eq("active"))

        # reset
        Polar::Subscription.update(
          "sub_01HNW7HXRN4WQRM5GDGPZ42K2N",
          {status: "inactive"}
        )
      end
    end

    describe ".delete" do
      it "deletes a subscription", :vcr do
        subscription = Polar::Subscription.delete("sub_01HNW7HXRN4WQRM5GDGPZ42K2N")
        expect(subscription.id).to(eq("sub_01HNW7HXRN4WQRM5GDGPZ42K2N"))
      end
    end

    describe ".list_for_customer" do
      it "returns a subscription list for customer", :vcr do
        subscriptions = Polar::Subscription.list_for_customer

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.first).to(be_a(Polar::Subscription))
      end

      it "takes params", :vcr do
        subscriptions = Polar::Subscription.list_for_customer(query: "xyz")

        expect(subscriptions).to(be_a(Array))
        expect(subscriptions.length).to be(0)
      end
    end

    describe ".get_for_customer" do
      it "returns a subscription for customer", :vcr do
        subscription = Polar::Subscription.get_for_customer("sub_01HNW7HXRN4WQRM5GDGPZ42K2N")

        expect(subscription).to(be_a(Polar::Subscription))
        expect(subscription.id).to(eq("sub_01HNW7HXRN4WQRM5GDGPZ42K2N"))
      end
    end

    describe ".update_for_customer" do
      it "updates a subscription for customer", :vcr do
        subscription = Polar::Subscription.update_for_customer(
          "sub_01HNW7HXRN4WQRM5GDGPZ42K2N",
          {status: "active"}
        )
        expect(subscription.status).to(eq("active"))

        # reset
        Polar::Subscription.update_for_customer(
          "sub_01HNW7HXRN4WQRM5GDGPZ42K2N",
          {status: "inactive"}
        )
      end
    end

    describe ".delete_for_customer" do
      it "deletes a subscription for customer", :vcr do
        subscription = Polar::Subscription.delete_for_customer("sub_01HNW7HXRN4WQRM5GDGPZ42K2N")
        expect(subscription.id).to(eq("sub_01HNW7HXRN4WQRM5GDGPZ42K2N"))
      end
    end
  end
end

