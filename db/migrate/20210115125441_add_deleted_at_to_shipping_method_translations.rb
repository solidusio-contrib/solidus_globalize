# frozen_string_literal: true

class AddDeletedAtToShippingMethodTranslations < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:spree_shipping_method_translations, :deleted_at)
      add_column :spree_shipping_method_translations, :deleted_at, :datetime
      add_index :spree_shipping_method_translations, :deleted_at
    end
  end
end
