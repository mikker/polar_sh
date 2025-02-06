# frozen_string_literal: true

require "json"
require "openssl"
require "base64"
require "uri"

# Constant time string comparison, for fixed length strings.
# Code borrowed from ActiveSupport
# https://github.com/rails/rails/blob/75ac626c4e21129d8296d4206a1960563cc3d4aa/activesupport/lib/active_support/security_utils.rb#L33
#
# The values compared should be of fixed length, such as strings
# that have already been processed by HMAC. Raises in case of length mismatch.
module StandardWebhooks
  if defined?(OpenSSL.fixed_length_secure_compare)
    def fixed_length_secure_compare(a, b)
      OpenSSL.fixed_length_secure_compare(a, b)
    end
  else
    def fixed_length_secure_compare(a, b)
      raise ArgumentError, "string length mismatch." unless a.bytesize == b.bytesize

      l = a.unpack("C#{a.bytesize}")

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end
  end

  module_function :fixed_length_secure_compare

  # Secure string comparison for strings of variable length.
  #
  # While a timing attack would not be able to discern the content of
  # a secret compared via secure_compare, it is possible to determine
  # the secret length. This should be considered when using secure_compare
  # to compare weak, short secrets to user input.
  def secure_compare(a, b)
    a.length == b.length && fixed_length_secure_compare(a, b)
  end

  module_function :secure_compare

  class StandardWebhooksError < StandardError
    attr_reader :message

    def initialize(message = nil)
      @message = message
    end
  end

  class WebhookVerificationError < StandardWebhooksError
  end

  class WebhookSigningError < StandardWebhooksError
  end

  class Webhook
    def self.new_using_raw_bytes(secret)
      self.new(secret.pack("C*").force_encoding("UTF-8"))
    end

    def initialize(secret)
      if secret.start_with?(SECRET_PREFIX)
        secret = secret[SECRET_PREFIX.length..-1]
      end

      @secret = Base64.decode64(secret)
    end

    def verify(payload, headers)
      msg_id = headers["webhook-id"]
      msg_signature = headers["webhook-signature"]
      msg_timestamp = headers["webhook-timestamp"]

      if !msg_signature || !msg_id || !msg_timestamp
        raise WebhookVerificationError, "Missing required headers"
      end

      verify_timestamp(msg_timestamp)

      _, signature = sign(msg_id, msg_timestamp, payload).split(",", 2)

      passed_signatures = msg_signature.split(" ")

      passed_signatures.each do |versioned_signature|
        version, expected_signature = versioned_signature.split(",", 2)

        if version != "v1"
          next
        end

        if ::StandardWebhooks::secure_compare(signature, expected_signature)
          return JSON.parse(payload, symbolize_names: true)
        end
      end

      raise WebhookVerificationError, "No matching signature found"
    end

    def sign(msg_id, timestamp, payload)
      begin
        now = Integer(timestamp)
      rescue
        raise WebhookSigningError, "Invalid timestamp"
      end

      to_sign = "#{msg_id}.#{timestamp}.#{payload}"
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), @secret, to_sign)).strip

      return "v1,#{signature}"
    end

    private

    SECRET_PREFIX = "whsec_"
    TOLERANCE = 5 * 60

    def verify_timestamp(timestamp_header)
      begin
        now = Integer(Time.now)
        timestamp = Integer(timestamp_header)
      rescue
        raise WebhookVerificationError, "Invalid Signature Headers"
      end

      if timestamp < (now - TOLERANCE)
        raise WebhookVerificationError, "Message timestamp too old"
      end

      if timestamp > (now + TOLERANCE)
        raise WebhookVerificationError, "Message timestamp too new"
      end
    end
  end
end
