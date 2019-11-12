# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module PropertyDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, :presentation, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable
        end
      end

      ::Spree::Property.prepend self
    end
  end
end
