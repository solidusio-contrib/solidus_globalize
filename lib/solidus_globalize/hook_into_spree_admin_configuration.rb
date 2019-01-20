module SolidusGlobalize
  module HookIntoSpreeAdminConfiguration
    before_action :update_solidus_globalize_settings, only: :update

    private

    def update_solidus_globalize_settings
      SolidusGlobalize::Config[:supported_locales] = params.permit(:supported_locales)
    end
  end

  if defined?(Spree::Admin::LocalesController)
    ::Spree::Admin::LocalesController.prepend HookIntoSpreeAdminConfiguration
  else
    ::Spree::Admin::StoresController.prepend HookIntoSpreeAdminConfiguration
  end
end
