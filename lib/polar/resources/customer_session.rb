# frozen_string_literal: true

module Polar
  class CustomerSession < Resource
    def self.create(params)
      response = Client.post_request("/v1/customer-sessions", **params)
      handle_one(response)
    end
  end
end
