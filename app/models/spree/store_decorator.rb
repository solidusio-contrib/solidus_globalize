module Spree
  module StoreDecorator
    def self.prepended(base)
      base.class_eval do
        translates :name, :meta_description, :meta_keywords, :seo_title,
                   fallbacks_for_empty_translations: true
        include SolidusGlobalize::Translatable
      end
    end

    ::Spree::Store.prepend self
  end
end
