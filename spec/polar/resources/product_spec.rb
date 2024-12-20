require "spec_helper"

module Polar
  RSpec.describe Product do
    describe ".list" do
      it "returns a product list", :vcr do
        products = Polar::Product.list

        expect(products).to(be_a(Array))
        expect(products.first).to(be_a(Polar::Product))
      end

      it "takes params", :vcr do
        products = Polar::Product.list(query: "xyz")

        expect(products).to(be_a(Array))
        expect(products.length).to be(0)
      end
    end

    describe ".create" do
      it "creates a product", :vcr do
        product = Polar::Product.create(
          name: "Test Product",
          prices: [{type: "one_time", amount_type: "fixed", price_amount: 100_00}],
          organization_id: ENV["POLAR_ORGANIZATION_ID"]
        )

        expect(product).to(be_a(Polar::Product))
        expect(product.name).to(eq("Test Product"))
      end
    end

    describe ".get" do
      it "returns a product", :vcr do
        product = Polar::Product.get("ed45370a-0425-43ef-9262-5579e81460b8")

        expect(product).to(be_a(Polar::Product))
        expect(product.name).to(eq("Test Product"))
      end
    end

    describe ".update" do
      it "updates a product", :vcr do
        product = Polar::Product.update("ed45370a-0425-43ef-9262-5579e81460b8", {name: "Updated Product"})
        expect(product.name).to(eq("Updated Product"))

        # reset
        Polar::Product.update("ed45370a-0425-43ef-9262-5579e81460b8", {name: "Test Product"})
      end
    end

    describe ".update_benefits" do
      it "updates a product benefits", :vcr do
        benefits_before = Product.get("ed45370a-0425-43ef-9262-5579e81460b8").benefits

        product = Polar::Product.update_benefits(
          "ed45370a-0425-43ef-9262-5579e81460b8",
          {benefits: []}
        )
        expect(product.benefits).to eq([])

        # reset
        Polar::Product.update_benefits(
          "ed45370a-0425-43ef-9262-5579e81460b8",
          benefits: benefits_before
        )
      end
    end
  end
end
