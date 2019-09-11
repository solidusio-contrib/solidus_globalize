module SolidusGlobalize
  module Spree
    module StoreDecorator
      def self.prepended(base)
        base.class_eval do
          translates(
            :name,
            :meta_description,
            :meta_keywords,
            :seo_title,
            fallbacks_for_empty_translations: true,
          )
        end

        base.include SolidusGlobalize::Translatable
      end

      ::Spree::Store.prepend self
    end
  end
end
