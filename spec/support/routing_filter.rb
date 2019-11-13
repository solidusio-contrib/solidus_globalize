require 'routing-filter'

# In this support file we simulate how we want routes to be in a real
# host application that uses solidus_i18n and solidus_globalize.
RSpec.configure do |config|
  config.before(:all) do
    Rails.application.routes.draw do
      filter :locale

      mount Spree::Core::Engine, at: '/'
    end
  end
end
