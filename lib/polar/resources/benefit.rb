# frozen_string_literal: true

module Polar
  class Benefit < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/benefits", **params)
      handle_list(response)
    end

    def self.create(params)
      response = Client.post_request("/v1/benefits", **params)
      handle_one(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/benefits/#{id}")
      handle_one(response)
    end

    def self.update(id, params)
      response = Client.patch_request("/v1/benefits/#{id}", **params)
      handle_one(response)
    end

    def self.delete(id)
      response = Client.delete_request("/v1/benefits/#{id}")
      handle_one(response)
    end
  end
end

