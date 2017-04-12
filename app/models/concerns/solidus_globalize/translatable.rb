module SolidusGlobalize
  module Translatable
    extend ActiveSupport::Concern

    included do |klass|
      set_translation_association
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

      def set_translation_association(association=:translations)
        if self.reflect_on_association(association)
          self.accepts_nested_attributes_for association
          self.whitelisted_ransackable_associations ||= []
          self.whitelisted_ransackable_associations |= [association.to_s]
        end
      end

    end
  end
end
