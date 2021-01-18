# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module ShippingMethodDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable

          after_discard do
            # Discard associated records
            translations.discard_all
          end

          translation_class.class_eval do
            # Paranoia soft delete
            acts_as_paranoid

            # Warn users of future Paranoia gem removal
            include ::Spree::ParanoiaDeprecations

            # Account for Paranoia migration
            include Discard::Model
            self.discard_column = :deleted_at

            # Paranoid sets the default scope and Globalize rewrites all query methods.
            # Therefore we prefer to unset the default_scopes over injecting 'unscope'
            # in every Globalize query method.
            self.default_scopes = []
          end
        end
      end

      ::Spree::ShippingMethod.prepend self
    end
  end
end
