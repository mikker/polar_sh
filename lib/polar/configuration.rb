# frozen_string_literal: true

module Polar
  class Configuration
    DEFAULT_API_VERSION = "2026-04"

    attr_accessor :access_token
    attr_accessor :sandbox
    attr_accessor :webhook_secret
    attr_writer :api_version

    alias sandbox? sandbox

    def api_version
      defined?(@api_version) ? @api_version : DEFAULT_API_VERSION
    end

    def endpoint
      "https://#{sandbox? ? "sandbox-api" : "api"}.polar.sh"
    end
  end
end
