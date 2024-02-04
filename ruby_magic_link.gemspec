# frozen_string_literal: true

require_relative 'lib/ruby_magic_link/version'

Gem::Specification.new do |s|
  s.name        = 'ruby_magic_link'
  s.version     = RubyMagicLink::VERSION
  s.summary     = 'Magic links for ruby web applications'
  s.description = 'Magic links for ruby web applications'
  s.authors     = ['Igor Korepanov']
  s.email       = 'noemail@example.com'
  s.files       = Dir.glob('{lib}/**/*') + %w[LICENSE.txt README.md]
  s.homepage    = 'https://github.com/igorkorepanov/ruby_magic_link'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7'
end
