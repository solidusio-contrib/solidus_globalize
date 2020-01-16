# frozen_string_literal: true

class AddTranslationMetaTitleToProduct < SolidusSupport::Migration[4.2]
  def up
    Spree::Product.add_translation_fields!({ meta_title: :string }, migrate_data: true)
  end

  def down
    remove_column :spree_product_translations, :meta_title
  end
end
