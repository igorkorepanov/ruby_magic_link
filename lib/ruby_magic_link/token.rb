# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'json'

module RubyMagicLink
  module Token
    DELIMITER = '!'
    ALGORITHM = 'AES-256-CBC'

    class TokenObject
      def initialize(data)
        @data = data
      end

      def expired?
        decoded_data['expires_in'] < Time.now.to_i
      end

      def payload
        decoded_data['payload']
      end

      private

      def decoded_data
        @decoded_data ||= RubyMagicLink::Token.decode_token(data)
      end

      attr_reader :data
    end

    module_function

    def create(payload, expires_in: nil)
      data = { payload: payload }
      data[:expires_in] = expires_in if expires_in
      iv = OpenSSL::Random.random_bytes(16)
      str = JSON.generate(data)
      Base64.urlsafe_encode64(Base64.urlsafe_encode64(iv) + DELIMITER + encrypt(str, RubyMagicLink.config.secret_key, iv))
    end

    def decode(data)
      TokenObject.new(data)
    end

    def decode_token(data)
      raw_iv, data =  Base64.urlsafe_decode64(data).split(DELIMITER, 2)
      JSON.parse(decrypt(data, RubyMagicLink.config.secret_key, Base64.urlsafe_decode64(raw_iv)))
    end

    def encrypt(data, key, iv)
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.encrypt
      cipher.key = key
      cipher.iv = iv
      cipher.update(data) + cipher.final
    end

    def decrypt(encrypted_data, key, iv)
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      cipher.update(encrypted_data) + cipher.final
    end
  end
end
