# frozen_string_literal: true

module Polar
  class Checkout
    class Custom < Resource
      def self.list(params = {})
        response = Client.get_request("/v1/checkouts/custom/", **params)
        handle_list(response, Checkout)
      end

      def self.create(params)
        params[:payment_processor] ||= "stripe"
        response = Client.post_request("/v1/checkouts/custom/", **params)
        handle_one(response, Checkout)
      end

      def self.get(id)
        response = Client.get_request("/v1/checkouts/custom/#{id}")
        handle_one(response, Checkout)
      end

      def self.update(id, params)
        response = Client.patch_request("/v1/checkouts/custom/#{id}", **params)
        handle_one(response, Checkout)
      end

      def self.client_get(client_secret)
        response = Client.get_request("/v1/checkouts/custom/client/#{client_secret}")
        handle_one(response, Checkout)
      end

      def self.client_update(client_secret, params)
        response = Client.patch_request("/v1/checkouts/custom/client/#{client_secret}", **params)
        handle_one(response, Checkout)
      end

      def self.client_confirm(client_secret)
        response = Client.post_request("/v1/checkouts/custom/client/#{client_secret}/confirm")
        handle_one(response, Checkout)
      end
    end
  end
end
