# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module ProductDecorator
      def self.prepended(base)
        base.class_eval do
          translates :name,
            :description,
            :meta_description,
            :meta_keywords,
            :slug,
            fallbacks_for_empty_translations: true

          friendly_id :slug_candidates, use: [:history, :globalize]

          include SolidusGlobalize::Translatable

          translation_class.class_eval do
            # Paranoia soft-deletes the associated records only if they are paranoid themselves.
            acts_as_paranoid

            # Paranoid sets the default scope and Globalize rewrites all query methods.
            # Therefore we prefer to unset the default_scopes over injecting 'unscope'
            # in every Globalize query method.
            self.default_scopes = []

            # Punch slug on every translation to allow reuse of original
            after_destroy :punch_slug

            def punch_slug
              update(slug: "#{Time.now.to_i}_#{slug}")
            end
          end

          # Allow to filter products through their translations, too
          def self.like_any(fields, values)
            translations = ::Spree::Product::Translation.arel_table
            source = fields.product(values, [translations, arel_table])
            clauses = source.map do |(field, value, arel)|
              arel[field].matches("%#{value}%")
            end.inject(:or)

            joins(:translations).where(translations[:locale].eq(I18n.locale)).where(clauses)
          end
        end
      end

      # Don't punch slug on original product as it prevents bulk deletion.
      # Also we don't need it, as it is translated.
      def punch_slug; end

      def duplicate_extra(old_product)
        duplicate_translations(old_product)
        self.slug = normalize_friendly_id(name)
      end

      private

      def duplicate_translations(old_product)
        old_product.translations.each do |translation|
          new_translation = translation.dup
          # we need to override the name of the default locale,
          # otherwise we'll have the name conflicting with the
          # old product. This name is set in Spree::ProductDuplicator
          # and contains the 'COPY OF ...' piece.
          new_translation.name = name if translation.locale == I18n.locale
          translations << new_translation
        end
      end

      ::Spree::Product.prepend self
    end
  end
end
