# frozen_string_literal: true

require "ostruct"
require "http"

require_relative "polar/version"
require "standard_webhooks"

module Polar
  autoload :Configuration, "polar/configuration"
  autoload :Client, "polar/client"
  autoload :Error, "polar/error"
  autoload :Resource, "polar/resource"
  autoload :Webhook, "polar/webhook"

  autoload :Benefit, "polar/resources/benefit"
  autoload :BenefitGrant, "polar/resources/benefit_grant"
  autoload :Customer, "polar/resources/customer"
  autoload :CustomerSession, "polar/resources/customer_session"
  autoload :Discount, "polar/resources/discount"
  autoload :Checkout, "polar/resources/checkout"
  autoload :LicenseKey, "polar/resources/license_key"
  autoload :Order, "polar/resources/order"
  autoload :Organization, "polar/resources/organization"
  autoload :Product, "polar/resources/product"
  autoload :Refund, "polar/resources/refund"
  autoload :Subscription, "polar/resources/subscription"
  autoload :User, "polar/resources/user"

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
