Spree::Admin::GeneralSettingsController.class_eval do
  before_action :update_globalize_settings, only: :update

  private

  def update_globalize_settings
    params.each do |name, value|
      next unless SolidusGlobalize::Config.has_preference? name
      SolidusGlobalize::Config[name] = value.map(&:to_sym)
    end
  end
end
