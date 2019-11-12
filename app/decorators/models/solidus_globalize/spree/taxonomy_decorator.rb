# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module TaxonomyDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name, fallbacks_for_empty_translations: true
          include SolidusGlobalize::Translatable
        end
      end

      ::Spree::Taxonomy.prepend self
    end
  end
end
