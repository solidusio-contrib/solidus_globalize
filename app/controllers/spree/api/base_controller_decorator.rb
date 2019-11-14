# frozen_string_literal: true

Spree::Api::BaseController.class_eval do
  include SolidusGlobalize::ControllerGlobalizeHelper
end
