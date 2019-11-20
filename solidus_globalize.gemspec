# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'solidus_globalize/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_globalize'
  s.version     = SolidusGlobalize.version
  s.summary     = 'Provides globalization features for Solidus.'
  s.description = s.summary

  s.authors = ['Thomas von Deyen', 'Alessandro Lepore', 'Diego Franciosi']
  s.homepage    = 'https://solidus.io/'
  s.license     = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_runtime_dependency 'deface', '~> 1.5'
  s.add_runtime_dependency 'friendly_id-globalize'
  s.add_runtime_dependency 'globalize', '~> 5.1'
  s.add_runtime_dependency 'solidus_support'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg', '~> 0.21'
  s.add_development_dependency 'pry-rails', '>= 0.3.0'
  s.add_development_dependency 'routing-filter', '~> 0.6'
  s.add_development_dependency 'sqlite3', '~> 1.4.1'
end
