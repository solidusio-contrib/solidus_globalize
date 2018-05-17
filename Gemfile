source 'https://rubygems.org'

gemspec

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', github: 'solidusio/solidus', branch: branch
gem 'solidus_i18n', github: 'solidusio-contrib/solidus_i18n', branch: 'master'

case branch
when 'v1.2', 'v1.3', 'v1.4'
  gem 'globalize', '~> 5.0.0' # for Rails 4.2
  gem 'rails_test_params_backport', group: :test
else
  gem 'globalize', '~> 5.1.0' # for Rails 5
end
