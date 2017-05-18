module Spree
  ProductProperty.class_eval do
    translates :value, fallbacks_for_empty_translations: true
    include SolidusGlobalize::Translatable

    ### Fix the cooperation between solidus_globalize and spree
    #
    # The Problem:
    #
    # 1. solidus_globalize wants to translate Spree::ProductProperty#value (beside others)
    # 2. globalize sets everything up, complains about the value column still existing
    #      DEPRECATION WARNING: You have defined translated attributes with
    #      names that conflict with columns on the model table. Globalize does
    #      not support this configuration anymore, remove or rename these
    #      columns.
    #      Model name (table name): Spree::ProductProperty (spree_product_properties)
    #      Attribute name(s): value
    # 3. globalize adds "value" to Spree::ProductProperty.ignored_columns
    #    (is considered a fix globalize/globalize#560)

    # 4. A custom validator in solidus breaks because the column is not "present"
    #    anymore (it is, but not visible to any AR introspection), but is assumed it
    #    is.

    # Here, we just remove this validation.
    broken_validations = self._validate_callbacks.select do |c|
      c.raw_filter.is_a?(Spree::Validations::DbMaximumLengthValidator) &&
        c.raw_filter.options[:field] == :value
    end

    broken_validations.each do |bv|
      self._validate_callbacks.delete(bv)
    end
  end
end
