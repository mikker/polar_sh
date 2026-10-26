require "spec_helper"

module Polar
  RSpec.describe Error do
    describe ".from_response" do
      it "names the status in the message" do
        response = HTTP::Response.new(
          status: 404,
          version: "1.1",
          body: %({"detail":"Not found"}),
          headers: {"Content-Type" => "application/json"},
          request: HTTP::Request.new(verb: :get, uri: "https://sandbox-api.polar.sh/v1/products/x")
        )

        error = Error.from_response(response)

        expect(error.message).to(eq(%(Not Found: #<Polar::Error::PolarError detail="Not found">)))
        expect(error.status.to_i).to(eq(404))
      end
    end
  end
end
