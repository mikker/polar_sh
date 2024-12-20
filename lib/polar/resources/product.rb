# frozen_string_literal: true

module Polar
  class Product < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/products", **params)
      handle_list(response)
    end

    def self.create(params)
      response = Client.post_request("/v1/products", **params)
      handle_one(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/products/#{id}")
      handle_one(response)
    end

    def self.update(id, params)
      response = Client.patch_request("/v1/products/#{id}", **params)
      handle_one(response)
    end

    def self.update_benefits(id, params)
      response = Client.post_request("/v1/products/#{id}/benefits", **params)
      handle_one(response)
    end
  end
end
