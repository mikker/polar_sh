module Polar
  class Webhook
    def initialize(request, secret: nil)
      unless (unencoded_secret = secret || Polar.config.webhook_secret) && unencoded_secret != ""
        raise ArgumentError, "No webhook secret provided, set Polar.config.webhook_secret"
      end

      @secret = Base64.encode64(unencoded_secret)
      @request = request
      @event = JSON.parse(request.raw_post)
    end

    attr_reader :secret, :request, :event

    def verify
      response = StandardWebhooks::Webhook.new(secret).verify(request.raw_post, request.headers)

      case (type = response["type"])
      when /^checkout\./
        {type:, data: response["data"], object: Checkout::Custom.handle_one(response["data"])}
      when /^order\./
        {type:, data: response["data"], object: Order.handle_one(response["data"])}
      when /^subscription\./
        {type:, data: response["data"], object: Subscription.handle_one(response["data"])}
      when /^refund\./
        {type:, data: response["data"], object: Refund.handle_one(response["data"])}
      when /^product\./
        {type:, data: response["data"], object: Product.handle_one(response["data"])}
      when /^pledge\./
        {type:, data: response["data"], object: Pledge.handle_one(response["data"])}
      when /^organization\./
        {type:, data: response["data"], object: Organization.handle_one(response["data"])}
      when /^benefit\./
        {type:, data: response["data"], object: Benefit.handle_one(response["data"])}
      else
        response
      end
    end

    def self.verify(request, secret: nil)
      new(request, secret: secret).verify
    end
  end
end
