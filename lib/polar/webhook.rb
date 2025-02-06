module Polar
  class Webhook
    def initialize(request, secret: nil)
      @secret = Base64.encode64(secret || Polar.config.webhook_secret)
      @request = request
      @event = JSON.parse(request.raw_post)
    end

    attr_reader :secret, :request, :event

    def verify
      StandardWebhooks::Webhook.new(@secret).verify(request.raw_post, request.headers)
      event
    rescue StandardWebhooks::StandardWebhooksError => e
      raise Polar::Error.new("Webhook verification failed: #{e.message}", error: e)
    end

    def self.verify(request)
      new.verify(request)
    end
  end
end
