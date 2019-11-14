# frozen_string_literal: true

module Spree
  ProductProperty.class_eval do
    translates :value, fallbacks_for_empty_translations: true
    include SolidusGlobalize::Translatable
  end
end
