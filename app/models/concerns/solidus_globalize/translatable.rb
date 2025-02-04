# frozen_string_literal: true

module SolidusGlobalize
  module Translatable
    extend ActiveSupport::Concern

    included do |klass|
      accepts_nested_attributes_for :translations
      if ::Spree.solidus_gem_version < Gem::Version.new('3.3')
        klass.whitelisted_ransackable_associations  ||= []
        klass.whitelisted_ransackable_associations |= ['translations']
      else
        klass.allowed_ransackable_associations ||= []
        klass.allowed_ransackable_associations |= ['translations']
      end

      klass.const_set("TranslationRansackable", Module.new).module_eval do
        def ransackable_attributes(*_args)
          authorizable_ransackable_attributes
        end

        def ransackable_associations(*_args)
          authorizable_ransackable_associations
        end

        "#{klass}::Translation".constantize.singleton_class.prepend(self)
      end
    end

    class_methods do
      def ransack(params = {}, options = {})
        params ||= {}
        names = params.keys

        names.each do |n|
          translated_attribute_names.each do |t|
            if n.to_s.starts_with? t.to_s
              params[:"translations_#{n}"] = params[n]
              params.delete n
            end
          end
        end

        super(params, options)
      end
      alias :search :ransack unless respond_to? :search

      # preload translations
      def spree_base_scopes
        super.includes(:translations).references(:translations)
      end
    end
  end
end
