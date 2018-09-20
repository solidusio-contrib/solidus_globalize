module Spree
  Variant.class_eval do

    def self.translated_attribute_names
      Product.translated_attribute_names.collect{|name| :"product_#{name}" } + OptionValue.translated_attribute_names.collect{|name| :"option_values_#{name}" }
    end

    include SolidusGlobalize::Translatable

    has_many :translations_product, through: :product, source: :translations
    has_many :translations_option_values, through: :option_values, source: :translations
    set_translation_association :translations_product
    set_translation_association :translations_option_values

  end
end