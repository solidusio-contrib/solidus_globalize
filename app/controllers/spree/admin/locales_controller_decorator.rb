Spree::Admin::LocalesController.class_eval do
  before_filter :update_i18n_settings, only: :update

  private

    def update_i18n_settings
      available_locales = params["available_locales"]
      SolidusGlobalize::Config["supported_locales"] = available_locales.map(&:to_sym)
    end
end
