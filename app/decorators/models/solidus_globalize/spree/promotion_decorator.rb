# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module PromotionDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, :description, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable
        end
      end

      ::Spree::Promotion.prepend self
    end
  end
end
