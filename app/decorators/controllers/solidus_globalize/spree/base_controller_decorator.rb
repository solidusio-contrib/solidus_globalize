# frozen_string_literal: true

module SolidusGlobalize
  module Spree
    module BaseControllerDecorator
      def self.prepended(base)
        base.class_eval do
          include SolidusGlobalize::ControllerGlobalizeHelper
        end
      end

      ::Spree::BaseController.prepend self
    end
  end
end
