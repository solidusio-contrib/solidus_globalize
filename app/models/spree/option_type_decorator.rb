# frozen_string_literal: true

module Spree
  OptionType.class_eval do
    translates :name, :presentation, fallbacks_for_empty_translations: true
    include SolidusGlobalize::Translatable
  end
end
