# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module ProductPropertyDecorator
      def self.prepended(base)
        base.class_eval do
          translates :value, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable
        end
      end

      ::Spree::ProductProperty.prepend self
    end
  end
end
