# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module Admin
      module ShippingMethodsControllerDecorator
        private

        def set_shipping_category
          super unless params['shipping_method'][:translations_attributes]
        end

        def set_zones
          super unless params['shipping_method'][:translations_attributes]
        end

        ::Spree::Admin::ShippingMethodsController.prepend self
      end
    end
  end
end
