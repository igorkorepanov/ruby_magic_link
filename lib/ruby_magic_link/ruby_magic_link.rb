# frozen_string_literal: true

module RubyMagicLink
  class Configuration
    attr_accessor :secret_key
  end

  class << self
    attr_accessor :config

    def setup
      self.config ||= Configuration.new
      yield(config)
    end
  end
end
