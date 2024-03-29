# frozen_string_literal: true

class AddTranslationsToStore < SolidusSupport::Migration[4.2]
  def up
    return if table_exists?(:spree_store_translations)

    params = { name: :string, meta_description: :text, meta_keywords: :text, seo_title: :string }
    Spree::Store.create_translation_table!(params, migrate_data: true)
  end

  def down
    Spree::Store.drop_translation_table! migrate_data: true
  end
end
