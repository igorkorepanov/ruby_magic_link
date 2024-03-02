# frozen_string_literal: true

require_relative 'lib/ruby_magic_link/version'

Gem::Specification.new do |s|
  s.name        = 'ruby_magic_link'
  s.version     = RubyMagicLink::VERSION
  s.summary     = 'Gem for generating encrypted tokens and magic links'
  s.description = <<-DESC
    Ruby Magic Link is a Ruby gem that provides functionality for generating encrypted tokens and magic links.
    It offers a simple and secure way to create tokens that can be used for various purposes, such as authentication,
    password reset, and email verification.
  DESC
  s.authors     = ['Igor Korepanov']
  s.email       = 'korepanovigor87@gmail.com'
  s.files       = Dir.glob('{lib}/**/*') + %w[LICENSE.txt README.md]
  s.homepage    = 'https://github.com/igorkorepanov/ruby_magic_link'
  s.metadata = {
    'rubygems_mfa_required' => 'true'
  }
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7'
end
