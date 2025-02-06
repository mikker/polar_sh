# frozen_string_literal: true

module Polar
  class Refund < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/refunds", **params)
      handle_list(response)
    end

    def self.create(params)
      response = Client.post_request("/v1/refunds", **params)
      handle_one(response)
    end
  end
end 