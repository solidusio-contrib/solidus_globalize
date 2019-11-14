# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    I18n.locale = I18n.default_locale
  end
end
