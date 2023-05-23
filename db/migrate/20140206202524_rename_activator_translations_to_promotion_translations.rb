# frozen_string_literal: true

class RenameActivatorTranslationsToPromotionTranslations < SolidusSupport::Migration[4.2]
  def change
    return unless table_exists? 'spree_activator_translations'

    rename_table :spree_activator_translations, :spree_promotion_translations
    rename_column :spree_promotion_translations, :spree_activator_id, :spree_promotion_id
  end
end
