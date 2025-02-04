# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module StoreDecorator
      def self.prepended(base)
        translatable_fields = ::SolidusGlobalize::Config.translatable_fields[base.to_s]
        base.class_eval do
          translates(*translatable_fields, fallbacks_for_empty_translations: true)
          include SolidusGlobalize::Translatable
        end
      end

      def available_locales
        # TODO, we should probably backport this change into core.
        # Instead of calling super we read the database attribute
        # Globalize overrides available_locales and super is returning
        # something an array, while we expect a string.
        locales = self[:available_locales]
        if locales
          locales.split(",").map(&:to_sym)
        else
          ::Spree.i18n_available_locales
        end
      end

      ::Spree::Store.prepend self
    end
  end
end
