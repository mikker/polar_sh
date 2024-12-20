# frozen_string_literal: true

module Polar
  class Resource < OpenStruct
    private

    class << self
      def handle_list(response, klass = nil)
        klass ||= self
        response.fetch("items").map { |attributes| klass.new(attributes) }
      end

      def handle_one(response, klass = nil)
        klass ||= self
        klass.new(response)
      end

      def handle_none(response)
        response
      end
    end
  end
end
