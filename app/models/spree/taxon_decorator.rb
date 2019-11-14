# frozen_string_literal: true

module Spree
  Taxon.class_eval do
    translates :name, :description, :meta_title, :meta_description, :meta_keywords,
      :permalink, fallbacks_for_empty_translations: true
    include SolidusGlobalize::Translatable
  end
end
