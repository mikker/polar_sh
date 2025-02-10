# frozen_string_literal: true

module Polar
  class BenefitGrant < Resource
    def self.list(params = {})
      response = Client.get_request("/v1/benefits/grants", **params)
      handle_list(response)
    end
  end
end
