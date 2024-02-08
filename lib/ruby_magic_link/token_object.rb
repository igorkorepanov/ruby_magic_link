# frozen_string_literal: true

module RubyMagicLink
  class TokenObject
    def initialize(data)
      @data = data
    end

    def valid?
      !expired?
    end

    def expired?
      if decoded_data['expires_in']
        decoded_data['expires_in'] < Time.now.to_i
      else
        false
      end
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
end
