module SolidusGlobalize
  module Spree
    module OptionTypeDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, :presentation, fallbacks_for_empty_translations: true
        end

        base.include SolidusGlobalize::Translatable
      end

      ::Spree::OptionType.prepend self
    end
  end
end
