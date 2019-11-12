# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module OptionValueDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, :presentation, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable
        end
      end

      ::Spree::OptionValue.prepend self
    end
  end
end
