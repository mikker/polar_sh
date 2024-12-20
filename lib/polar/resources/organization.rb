# frozen_string_literal: true

module Polar
  class Organization < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/organizations", **params)
      handle_list(response)
    end

    def self.create(params = {})
      response = Client.post_request("/v1/organizations", **params)
      handle_one(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/organizations/#{id}")
      handle_one(response)
    end

    def self.update(id, params = {})
      response = Client.patch_request("/v1/organizations/#{id}", **params)
      handle_one(response)
    end
  end
end
