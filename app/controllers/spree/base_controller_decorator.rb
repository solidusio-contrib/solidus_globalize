# frozen_string_literal: true

Spree::BaseController.class_eval do
  include SolidusGlobalize::ControllerGlobalizeHelper
end
