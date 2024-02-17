# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'json'

module RubyMagicLink
  module Token
    DELIMITER = '|'
    ALGORITHM = 'AES-256-CBC'

    module_function

    def create(payload, expires_in: nil)
      data = { payload: payload }
      if expires_in
        raise(StandardError, '`expires_at` must be an Integer') unless expires_in.is_a? Integer

        data[:expires_in] = Time.now.to_i + expires_in
      end
      iv = OpenSSL::Random.random_bytes(16)
      encrypted_data = encrypt(JSON.generate(data), RubyMagicLink.config.secret_key, iv)
      Base64.urlsafe_encode64(Base64.urlsafe_encode64(iv) + DELIMITER + encrypted_data)
    end

    def decode(data)
      RubyMagicLink::TokenObject.new(data)
    end

    def decode_token(token)
      raw_iv, data = Base64.urlsafe_decode64(token).split(DELIMITER, 2)
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
