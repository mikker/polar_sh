require "polar_sh"

require "vcr"
require "dotenv/load"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into(:webmock)
  config.filter_sensitive_data("<AUTHORIZATION>") { ENV["POLAR_ACCESS_TOKEN"] }
  config.configure_rspec_metadata!
end

Polar.configure do |config|
  config.sandbox = true
  config.access_token = ENV["POLAR_ACCESS_TOKEN"]
end

RSpec.configure do |config|
end
