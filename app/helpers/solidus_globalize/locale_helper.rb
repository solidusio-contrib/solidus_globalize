module SolidusGlobalize
  module LocaleHelper
    def select_supported_locales
      select_tag(
        'supported_locales[]',
        options_for_select(Config.supported_locales)
      )
    end

    def select_available_locales_fields
      select_tag(
        'locale',
        options_for_select(Config.supported_locales)
      )
    end

    def supported_locales_options
      Config.supported_locales.map { |locale| locale_presentation(locale) }
    end
  end
end
