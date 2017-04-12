module Spree
  Variant.class_eval do

    def self.translated_attribute_names
      Product.translated_attribute_names.collect{|name| :"product_#{name}" }
    end

    include SolidusGlobalize::Translatable

    has_many :translations_product, through: :product,source: :translations
    set_translation_association :translations_product

  end
end
