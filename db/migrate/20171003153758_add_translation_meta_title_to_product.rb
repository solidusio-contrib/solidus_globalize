class AddTranslationMetaTitleToProduct < SolidusSupport::Migration[4.2]
  def change
    reversible do |dir|
      dir.up do
        Spree::Product.add_translation_fields! meta_title: :string
      end

      dir.down do
        remove_column :spree_product_translations, :meta_title
      end
    end
  end
end