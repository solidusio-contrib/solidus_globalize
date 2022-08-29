# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'solidus_globalize/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_globalize'
  s.version     = SolidusGlobalize::VERSION
  s.summary     = 'Provides globalization features for Solidus.'
  s.description = s.summary

  s.authors = ['Thomas von Deyen', 'Alessandro Lepore', 'Diego Franciosi']
  s.homepage    = 'https://solidus.io/'
  s.license     = 'BSD-3'

  if s.respond_to?(:metadata)
    s.metadata["homepage_uri"] = s.homepage if s.homepage
    s.metadata["source_code_uri"] = 'https://github.com/solidusio-contrib/solidus_globalize'
  end

  s.required_ruby_version = ['>= 2.4', '< 4.0']

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.test_files = Dir['spec/**/*']
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.requirements << 'none'

  s.add_dependency 'deface', '~> 1.5'
  s.add_dependency 'friendly_id-globalize'
  s.add_dependency 'globalize', '~> 6.0'
  s.add_dependency 'solidus_core', ['>= 2.0.0', '< 4']
  s.add_dependency 'solidus_support', '~> 0.8'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'pry-rails', '>= 0.3.0'
  s.add_development_dependency 'routing-filter', '~> 0.6'
  s.add_development_dependency 'solidus_dev_support'
end
