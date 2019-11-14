# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    get '/:resource/:resource_id/translations' => 'translations#index', as: :translations
    patch '/option_values/:id' => 'option_values#update', as: :option_type_option_value
    patch 'product/:id/product_properties/:id' => "product_properties#translate", as: :translate_product_property
  end
end
