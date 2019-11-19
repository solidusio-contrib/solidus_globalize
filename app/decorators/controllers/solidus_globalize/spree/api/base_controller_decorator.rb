# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module Api
      module BaseControllerDecorator
        def self.prepended(base)
          base.class_eval do
            include SolidusGlobalize::ControllerGlobalizeHelper
          end
        end

        ::Spree::Api::BaseController.prepend self
      end
    end
  end
end
