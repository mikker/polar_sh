# frozen_string_literal: true

module Polar
  class Subscription < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/subscriptions", **params)
      handle_list(response)
    end

    def self.export(params = {})
      response = Client.get_request("/v1/subscriptions/export", **params)
      handle_list(response)
    end

    def self.get(id)
      response = Client.get_request("/v1/subscriptions/#{id}")
      handle_one(response)
    end

    def self.update(id, params)
      response = Client.patch_request("/v1/subscriptions/#{id}", **params)
      handle_one(response)
    end

    def self.delete(id)
      response = Client.delete_request("/v1/subscriptions/#{id}")
      handle_one(response)
    end

    # Customer Portal methods
    def self.list_for_customer(params = {})
      response = Client.get_request("/v1/customer-portal/subscriptions", **params)
      handle_list(response)
    end

    def self.get_for_customer(id)
      response = Client.get_request("/v1/customer-portal/subscriptions/#{id}")
      handle_one(response)
    end

    def self.update_for_customer(id, params)
      response = Client.patch_request("/v1/customer-portal/subscriptions/#{id}", **params)
      handle_one(response)
    end

    def self.delete_for_customer(id)
      response = Client.delete_request("/v1/customer-portal/subscriptions/#{id}")
      handle_one(response)
    end
  end
end

