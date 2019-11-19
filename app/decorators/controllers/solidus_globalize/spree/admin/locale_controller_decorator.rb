# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module Admin
      module LocaleControllerDecorator
        def self.prepended(base)
          base.class_eval do
            before_action :update_i18n_settings, only: :update
          end
        end

        private

        def update_i18n_settings
          params.each do |name, value|
            next unless SolidusGlobalize::Config.has_preference? name

            SolidusGlobalize::Config[name] = value.map(&:to_sym)
          end
        end

        ::Spree::Admin::LocaleController.prepend self
      end
    end
  end
end
