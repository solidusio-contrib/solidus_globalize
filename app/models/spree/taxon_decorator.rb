module Spree
  Taxon.class_eval do
    translates :name, :description, :meta_title, :meta_description, :meta_keywords,
      :permalink, fallbacks_for_empty_translations: true
    include SolidusGlobalize::Translatable

    # workaround https://github.com/globalize/globalize/issues/423#issuecomment-133725817
    def self.find_by(*args)
      self.where(*args).take
    end
    
  end
end
