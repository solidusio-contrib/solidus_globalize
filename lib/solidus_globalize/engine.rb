# frozen_string_literal: true

require 'spree/core'
require 'globalize'
require 'friendly_id/globalize'

module SolidusGlobalize
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions::Decorators

    isolate_namespace ::Spree

    engine_name 'solidus_globalize'

    initializer "solidus_globalize.environment", before: :load_config_initializers do
      SolidusGlobalize::Config = SolidusGlobalize::Configuration.new
    end

    initializer "solidus_globalize.permitted_attributes", before: :load_config_initializers do
      taxon_attributes = {
        translations_attributes: [
          :id,
          :locale,
          :name,
          :description,
          :permalink,
          :meta_description,
          :meta_keywords,
          :meta_title,
        ]
      }
      Spree::PermittedAttributes.taxon_attributes << taxon_attributes

      option_value_attributes = {
        translations_attributes: [
          :id,
          :locale,
          :name,
          :presentation,
        ]
      }
      Spree::PermittedAttributes.option_value_attributes << option_value_attributes

      store_attributes = {
        translations_attributes: [
          :id,
          :locale,
          :name,
          :meta_description,
          :meta_keywords,
          :seo_title,
        ]
      }
      Spree::PermittedAttributes.store_attributes << store_attributes
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
