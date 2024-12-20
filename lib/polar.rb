# frozen_string_literal: true

require "ostruct"
require "http"

require_relative "polar/version"

module Polar
  autoload :Configuration, "polar/configuration"
  autoload :Client, "polar/client"
  autoload :Error, "polar/error"
  autoload :Resource, "polar/resource"

  autoload :User, "polar/resources/user"
  autoload :Product, "polar/resources/product"
  autoload :Organization, "polar/resources/organization"
  autoload :LicenseKey, "polar/resources/license_key"

  class << self
    attr_writer :config
  end

  def self.configure
    yield(config) if block_given?
  end

  def self.config
    @config ||= Configuration.new
  end
end
