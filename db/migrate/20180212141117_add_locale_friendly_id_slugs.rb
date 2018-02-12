class AddLocaleFriendlyIdSlugs < SolidusSupport::Migration[4.2]
  def up
    unless column_exists?(:friendly_id_slugs, :locale)
      add_column :friendly_id_slugs, :locale, :string
    end
  end

  def down
    remove_column :friendly_id_slugs, :locale, :string
  end
end
