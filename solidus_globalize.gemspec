# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'solidus_globalize/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_globalize'
  s.version     = SolidusGlobalize.version
  s.summary     = 'Provides globalization features for Solidus.'
  s.description = s.summary

  s.authors      = ['Thomas von Deyen', 'Alessandro Lepore', 'Diego Franciosi']
  s.homepage    = 'https://solidus.io/'
  s.license     = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_runtime_dependency 'friendly_id-globalize'
  s.add_runtime_dependency 'globalize', '~> 5.0'
  s.add_runtime_dependency 'solidus_i18n', '~> 2.0'
  s.add_runtime_dependency 'solidus_support'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner', '~> 1.3'
  s.add_development_dependency 'factory_bot', '~> 4.5'
  s.add_development_dependency 'ffaker', '>= 1.25.0'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg', '~> 0.21'
  s.add_development_dependency 'poltergeist', '~> 1.5'
  s.add_development_dependency 'pry-rails', '>= 0.3.0'
  s.add_development_dependency 'rubocop', '>= 0.24.1'
  s.add_development_dependency 'rspec-rails', '~> 3.1'
  s.add_development_dependency 'sqlite3', '~> 1.3.10'
  s.add_development_dependency 'simplecov', '~> 0.9.0'
  s.add_development_dependency 'guard-rspec', '>= 4.2.0'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'friendly_id', '~> 5.0.4'
end
