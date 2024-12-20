# frozen_string_literal: true

module Polar
  class Error < StandardError
    class PolarError < OpenStruct
    end

    def initialize(message, error: nil, status: nil)
      @message = message
      @error = error
      @status = status
    end

    attr_reader :message, :error, :status

    def self.from_response(response)
      error = PolarError.new(response.parse)
      new(name_for(response.status), error:, status: response.status)
    end

    def message
      super + ": #{@error.inspect}"
    end

    class << self
      private

      def name_for(status)
        case status
        when 400
          "Bad Request"
        when 401
          "Unauthorized"
        when 403
          "Forbidden"
        when 404
          "Not Found"
        when 422
          "Unprocessable Entity"
        when 429
          "Too Many Requests"
        when 500
          "Internal Server Error"
        when 503
          "Service Unavailable"
        else
          "Unknown Error"
        end
      end
    end
  end
end
