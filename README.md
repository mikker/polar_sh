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
end

# Fetch a list of customers
pp Polar::Customer.list
```

## Development

```sh
$ bundle
$ rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikker/polar_sh.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
