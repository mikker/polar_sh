# frozen_string_literal: true

module Polar
  class Discount < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/discounts", **params)
      handle_list(response)
    end

    def self.create(params)
      response = Client.post_request("/v1/discounts", **params)
      handle_one(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/discounts/#{id}")
      handle_one(response)
    end

    def self.update(id, params)
      response = Client.patch_request("/v1/discounts/#{id}", **params)
      handle_one(response)
    end

    def self.delete(id)
      response = Client.delete_request("/v1/discounts/#{id}")
      handle_none(response)
    end
  end
end
