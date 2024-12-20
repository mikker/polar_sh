# frozen_string_literal: true

require "logger"

module Polar
  class Client
    class << self
      def connection
        @connection ||= HTTP
          .persistent(Polar.config.endpoint)
          .follow
          .auth("Bearer #{Polar.config.access_token}")
          .headers(
            accept: "application/json",
            content_type: "application/json",
            user_agent: "polar_sh/v#{VERSION} (github.com/mikker/polar_sh)"
          )
        # .use(logging: {logger: Logger.new(STDOUT)})
      end

      def get_request(path, **params)
        response = connection.get(path, params:)
        return response.parse if response.status.success?
        raise Error.from_response(response)
      end

      def post_request(path, **params)
        response = connection.post(path, json: params)
        return response.parse if response.status.success?
        raise Error.from_response(response)
      end

      def patch_request(path, **params)
        response = connection.patch(path, json: params)
        return response.parse if response.status.success?
        raise Error.from_response(response)
      end

      def delete_request(path, **params)
        response = connection.delete(path, json: params)
        return true if response.status.success?
        raise Error.from_response(response)
      end
    end
  end
end
