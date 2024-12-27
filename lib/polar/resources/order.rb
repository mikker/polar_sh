# frozen_string_literal: true

module Polar
  class Order < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/orders", **params)
      handle_list(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/orders/#{id}")
      handle_one(response)
    end

    def self.get_invoice(id)
      response = Client.get_request("/v1/orders/#{id}/invoice")
      handle_one(response, Invoice)
    end
  end
end
