module SolidusGlobalize::ResourceControllerDecorator
  def parent
    if parent_data.present?
      @parent ||= parent_data[:model_class].find_by(parent_data[:find_by] => params["#{model_name}_id"])
      instance_variable_set("@#{model_name}", @parent)
    end
  end
end

if SolidusSupport.solidus_gem_version >= Gem::Version.new("2.0") &&
   SolidusSupport.solidus_gem_version < Gem::Version.new("2.3")
  Spree::Admin::ResourceController.prepend(SolidusGlobalize::ResourceControllerDecorator)
end
