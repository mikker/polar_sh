# Polar.sh Ruby API client

Still in development. [API docs](https://docs.polar.sh/api)

## Installation

```bash
bundle add polar_sh
```

## Usage

```ruby
Polar.configure do |config|
  config.access_token = "polar_..."
  config.sandbox = true
  config.webhook_secret = "xyz..."
end

class CheckoutsController < ApplicationController
  def create
    checkout = Polar::Checkout::Custom.create(
      customer_email: current_user.email,
      metadata: {user_id: current_user.id},
      product_id: "xyzxyz-...",
      success_url: root_path
    )

    redirect_to(checkout.url, allow_other_host: true)
  end
end

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle_polar
    event = Polar::Webhook.verify(request)

    Rails.logger.info("Received Polar webhook: #{event.type}")

    case event.type
    when "order.created"
      process_order(event.object)
    end

    head(:ok)
  end

  private

  def process_order(order)
    return unless order.status == "paid"
    return unless (user = User.find(order.metadata[:user_id]))

    # ...
  end
end
```

## Development

```sh
bundle
rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/mikker/polar_sh>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
