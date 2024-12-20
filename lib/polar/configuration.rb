# frozen_string_literal: true

module Polar
  class Configuration
    attr_accessor :api_key
    attr_accessor :sandbox

    alias sandbox? sandbox

    def endpoint
      "https://#{sandbox? ? "sandbox-api" : "api"}.polar.sh"
    end
  end
end
