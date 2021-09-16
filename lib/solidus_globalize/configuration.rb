# frozen_string_literal: true

module SolidusGlobalize
  class Configuration < Spree::Preferences::Configuration
    # These configs intend to, respectively:
    #
    #   Say which Globalized inputs are displayed on backend
    #   Set locales that should be available for end users
    #
    # e.g. If available_locales are [:en, :es] admin can translate model records
    # to spanish as well. Once it's done :es can be added to supported_locales
    preference :supported_locales, :array, default: [:en]

    preference(:translatable_fields, :hash,
      default: {
        'Spree::OptionType' => [:name, :presentation],
        'Spree::OptionValue' => [:name, :presentation],
        'Spree::Product' => [
          :name,
          :description,
          :meta_description,
          :meta_keywords,
          :meta_title,
          :slug
        ],
        'Spree::ProductProperty' => [:value],
        'Spree::Promotion' => [:name, :description],
        'Spree::Property' => [:name, :presentation],
        'Spree::ShippingMethod' => [:name],
        'Spree::Store' => [
          :name,
          :meta_description,
          :meta_keywords,
          :seo_title
        ],
        'Spree::Taxon' => [
          :name,
          :description,
          :meta_title,
          :meta_description,
          :meta_keywords,
          :permalink
        ],
        'Spree::Taxonomy' => [:name],
      })
  end
end
