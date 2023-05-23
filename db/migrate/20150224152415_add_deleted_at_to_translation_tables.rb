# frozen_string_literal: true

class AddDeletedAtToTranslationTables < SolidusSupport::Migration[4.2]
  def change
    return if column_exists?(:spree_product_translations, :deleted_at)

    add_column :spree_product_translations, :deleted_at, :datetime
    add_index :spree_product_translations, :deleted_at
  end
end
