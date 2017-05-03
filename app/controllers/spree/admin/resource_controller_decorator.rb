Spree::Admin::ResourceController.class_eval do
  def parent
    if parent_data.present?
      @parent ||= parent_data[:model_class].find_by("#{parent_data[:find_by]}": params["#{model_name}_id"])
      instance_variable_set("@#{model_name}", @parent)
    end
  end
end
