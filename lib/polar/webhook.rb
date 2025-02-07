module Polar
  class Webhook
    def initialize(request, secret: nil)
      unless (unencoded_secret = secret || Polar.config.webhook_secret) && unencoded_secret != ""
        raise ArgumentError, "No webhook secret provided, set Polar.config.webhook_secret"
      end

      @secret = Base64.encode64(unencoded_secret)
      @request = request
      @payload = JSON.parse(request.raw_post, symbolize_names: true)
      @type = @payload[:type]
      @object = cast_object
    end

    attr_reader :secret, :request, :payload, :type, :object

    def verify
      StandardWebhooks::Webhook.new(@secret).verify(request.raw_post, request.headers)
      self
    end

    def cast_object
      case type
      when /^checkout\./
        Checkout::Custom.handle_one(payload[:data])
      when /^order\./
        Order.handle_one(payload[:data])
      when /^subscription\./
        Subscription.handle_one(payload[:data])
      when /^refund\./
        Refund.handle_one(payload[:data])
      when /^product\./
        Product.handle_one(payload[:data])
      when /^pledge\./
        Pledge.handle_one(payload[:data])
      when /^organization\./
        Organization.handle_one(payload[:data])
      when /^benefit\./
        Benefit.handle_one(payload[:data])
      end
    end

    def self.verify(request, secret: nil)
      new(request, secret: secret).verify
    end
  end
end
