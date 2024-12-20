# frozen_string_literal: true

module Polar
  class Resource < OpenStruct
    private

    class << self
      def handle_list(response)
        response.fetch("items").map { |attributes| new(attributes) }
      end

      def handle_one(response)
        new(response)
      end
    end
  end
end
