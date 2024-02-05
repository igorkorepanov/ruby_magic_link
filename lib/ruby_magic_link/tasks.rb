# frozen_string_literal: true

require 'rake'
require 'securerandom'

namespace :ruby_magic_link do
  task :generate_key do
    puts SecureRandom.hex(16)
  end
end