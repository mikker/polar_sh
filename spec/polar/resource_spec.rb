require "spec_helper"

module Polar
  RSpec.describe Resource do
    describe "#method_missing" do
      it "returns the value of the attribute" do
        resource = Resource.new(foo: "bar")
        expect(resource.foo).to(eq("bar"))
      end

      it "returns the value of the attribute" do
        resource = Resource.new(foo: "bar")
        expect(resource.bar).to be_nil
      end
    end
  end
end
