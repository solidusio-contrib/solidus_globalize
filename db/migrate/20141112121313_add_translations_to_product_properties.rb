# frozen_string_literal: true

class AddTranslationsToProductProperties < SolidusSupport::Migration[4.2]
  def up
    return if table_exists?(:spree_product_property_translations)

    params = { value: :string }
    Spree::ProductProperty.create_translation_table!(params, migrate_data: true)
  end

  def down
    Spree::ProductProperty.drop_translation_table! migrate_data: true
  end
end
