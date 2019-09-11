module SolidusGlobalize
  module Spree
    module ProductPropertyDecorator
      def self.prepended(base)
        base.class_eval do
          translates :value, fallbacks_for_empty_translations: true
        end

        base.include SolidusGlobalize::Translatable
      end

      ::Spree::ProductProperty.prepend self
    end
  end
end
