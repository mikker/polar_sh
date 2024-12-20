require "polar_sh"

require "vcr"
require "dotenv/load"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into(:webmock)
  config.filter_sensitive_data("<AUTHORIZATION>") { ENV["POLAR_API_KEY"] }
  config.configure_rspec_metadata!
end

Polar.configure do |config|
  config.sandbox = true
  config.api_key = ENV["POLAR_API_KEY"]
end

RSpec.configure do |config|
end
