# frozen_string_literal: true

module Polar
  class LicenseKey < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/license-keys", **params)
      handle_list(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/license-keys/#{id}")
      handle_one(response)
    end

    def self.update(id, params)
      response = Client.patch_request("/v1/license-keys/#{id}", **params)
      handle_one(response)
    end

    def self.get_activation(id, activation_id)
      response = Client.get_request("/v1/license-keys/#{id}/activations/#{activation_id}")
      handle_one(response)
    end
  end
end
