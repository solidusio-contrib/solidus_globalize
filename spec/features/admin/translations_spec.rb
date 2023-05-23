# frozen_string_literal: true

RSpec.describe "Translations", :js do
  stub_authorization!
  include_context 'with pt-BR locale file in place'

  let(:language) { I18n.t(:this_file_language, scope: 'spree.i18n', locale: 'pt-BR') }
  let!(:store) { create(:store, available_locales: available_locales) }
  let(:available_locales) { [:en, :'pt-BR'] }

  before do
    create(:store, available_locales: available_locales)
    SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR']
  end

  after do
    SolidusGlobalize::Config.supported_locales = [:en]
  end

  context "products" do
    let(:product) { create(:product) }

    context "fills in translations fields" do
      it "saves translated attributes properly" do
        visit spree.admin_product_path(product)
        click_on "Translations"

        within("#attr_fields .name.en") { fill_in_name "Pearl Jam" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .name.pt-BR") { fill_in_name "Geleia de perola" }
        click_on "Update"

        click_on "Translations"
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .name.pt-BR") do
          expect(page).to have_field(with: 'Geleia de perola')
        end
      end
    end

    context "product properties" do
      let!(:product_property) { create(:product_property, value: "red") }

      it "saves translated attributes properly" do
        visit spree.admin_product_product_properties_path(product_property.product)
        within_row(1) { click_icon :globe }
        click_on "Value"
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .value.pt-BR") { fill_in_name "vermelho" }
        click_on "Update"

        visit spree.admin_product_product_properties_path(product_property.product)
        within_row(1) { click_icon :globe }
        click_on "Value"
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .value.pt-BR") do
          expect(page).to have_field(with: 'vermelho')
        end
      end
    end

    context "option types" do
      let!(:option_type) { create(:option_value).option_type }

      it "saves translated attributes properly" do
        visit spree.admin_option_types_path
        within_row(1) { click_icon :globe }
        within("#attr_fields .name.en") { fill_in_name "shirt sizes" }
        within("#attr_list") { click_on "Presentation" }
        within("#attr_fields .presentation.en") { fill_in_name "size" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") { fill_in_name "tamanho" }
        click_on "Update"

        visit spree.admin_option_types_path
        within_row(1) { click_icon :globe }
        within("#attr_list") { click_on "Presentation" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") do
          expect(page).to have_field(with: 'tamanho')
        end
      end

      # Regression test for issue #354
      it "successfully creates an option type and go to its edit page" do
        visit spree.admin_option_types_path
        click_link "New Option Type"
        fill_in "Name", with: "Shirt Size"
        fill_in "Presentation", with: "Sizes"
        click_button "Create"

        expect(page).to have_text_like 'has been successfully created'
        expect(page).to have_text_like 'Option Values'
      end
    end

    context "option values" do
      let!(:option_type) { create(:option_value).option_type }

      it "saves translated attributes properly" do
        visit spree.admin_option_types_path
        within_row(1) { click_icon :globe }

        within("#attr_fields .name.en") { fill_in_name "big" }
        within("#attr_list") { click_on "Presentation" }
        within("#attr_fields .presentation.en") { fill_in_name "big" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") { fill_in_name "grande" }
        click_on "Update"

        visit spree.admin_option_types_path
        within_row(1) { click_icon :globe }
        within("#attr_list") { click_on "Presentation" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") do
          expect(page).to have_field(with: 'grande')
        end
      end
    end

    context "properties" do
      let!(:property) { create(:property) }

      it "saves translated attributes properly" do
        visit spree.admin_properties_path
        within_row(1) { click_icon :globe }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .name.pt-BR") { fill_in_name "Modelo" }

        within("#attr_list") { click_on "Presentation" }
        select2("en", from: 'Select Locale')
        within("#attr_fields .presentation.en") { fill_in_name "Model" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") { fill_in_name "Modelo" }
        click_on "Update"

        visit spree.admin_properties_path
        within_row(1) { click_icon :globe }
        within("#attr_list") { click_on "Presentation" }
        select2("pt-BR", from: 'Select locale')
        within("#attr_fields .presentation.pt-BR") do
          expect(page).to have_field(with: 'Modelo')
        end
      end
    end
  end

  context "promotions" do
    let!(:promotion) { create(:promotion) }

    it "saves translated attributes properly" do
      visit spree.admin_promotions_path
      within_row(1) { click_icon :globe }

      within("#attr_fields .name.en") { fill_in_name "All free" }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") { fill_in_name "Salve salve" }
      click_on "Update"

      visit spree.admin_promotions_path
      within_row(1) { click_icon :globe }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") do
        expect(page).to have_field(with: 'Salve salve')
      end
    end

    it "render edit route properly" do
      visit spree.admin_promotions_path
      within_row(1) { click_icon :globe }
      expect(page).to have_current_path(%r{/admin/promotions/\d+/translations\z})
      click_on 'Cancel'
      expect(page).to have_current_path(%r{/admin/promotions/\d+/edit\z})
    end
  end

  context "taxonomies" do
    let!(:taxonomy) { create(:taxonomy) }

    it "saves translated attributes properly" do
      visit spree.admin_taxonomies_path
      within_row(1) { click_icon :globe }

      within("#attr_fields .name.en") { fill_in_name "Guitars" }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") { fill_in_name "Guitarras" }
      click_on "Update"

      visit spree.admin_taxonomies_path
      within_row(1) { click_icon :globe }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") do
        expect(page).to have_field(with: 'Guitarras')
      end
    end
  end

  context 'taxons' do
    let!(:taxonomy) { create(:taxonomy) }
    let!(:taxon) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }

    it "saves translated attributes properly" do
      visit spree.admin_translations_path('taxons', taxon.id)

      within("#attr_fields .name.en") { fill_in_name "Acoustic" }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") { fill_in_name "Acusticas" }
      click_on "Update"

      visit spree.admin_translations_path('taxons', taxon.id)

      # ensure we're not duplicating translated records on database
      expect {
        click_on "Update"
      }.not_to change { taxon.translations.count }

      # ensure taxon is in root or it will not be visible
      expect(taxonomy.root.children.count).to be(1)

      visit spree.admin_translations_path('taxons', taxon.id)
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") do
        expect(page).to have_field(with: 'Acusticas')
      end
    end
  end

  context "store" do
    it 'saves translated attributes properly' do
      visit spree.edit_admin_general_settings_path
      click_link I18n.t(:'spree.globalize.store_translations')
      select2("pt-BR", from: 'Select locale')

      within("#attr_fields .name.pt-BR") { fill_in_name "nome store" }
      click_on "Update"

      visit spree.admin_translations_path('stores', store)
      select2("pt-BR", from: 'Select locale')

      within("#attr_fields .name.pt-BR") do
        expect(page).to have_field(with: 'nome store')
      end
    end
  end

  context "shipping methods" do
    let(:shipping_category) { create(:shipping_category) }
    let!(:shipping_method) { create(:shipping_method, shipping_categories: [shipping_category]) }

    it 'saves translated attributes properly' do
      visit spree.admin_translations_path('shipping_methods', shipping_method.id)

      within("#attr_fields .name.en") { fill_in_name "Urgent elivery" }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") { fill_in_name "Entrega urgente" }
      click_on "Update"

      visit spree.admin_translations_path('shipping_methods', shipping_method.id)
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") do
        expect(page).to have_field(with: 'Entrega urgente')
      end
    end

    it "render edit route properly" do
      visit spree.admin_shipping_methods_path
      within_row(1) { click_icon :globe }
      expect(page).to have_current_path(%r{/admin/shipping_methods/\d+/translations\z})
      click_on 'Cancel'

      expect(page).to have_current_path(%r{/admin/shipping_methods/\d+/edit\z})
    end
  end

  context "localization settings" do
    let(:language) { I18n.t(:this_file_language, scope: 'spree.i18n', locale: 'pt-BR') }

    before do
      create(:store, available_locales: [:en])
      visit spree.edit_admin_general_settings_path
      within_row(3) { click_icon :edit }
    end

    it "adds portugues to supported locales" do
      targetted_select2_search(language, from: '#store_available_locales_field input')
      click_on 'Update'
      expect(SolidusGlobalize::Config.supported_locales).to include(:'pt-BR')
    end
  end

  context "permalink routing" do
    let(:language) { I18n.t(:this_file_language, scope: 'spree.i18n', locale: 'pt-BR') }
    let(:product) { create(:product) }
    let(:available_locales) { [:en, :'pt-BR'] }

    it "finds the right product with permalink in another language" do
      SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR']

      visit spree.admin_product_path(product)
      click_on "Translations"

      click_on "Name"
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .name.pt-BR") { fill_in_name "Produtos" }

      click_on "Slug"
      select2("en", from: 'Select Locale')
      within("#attr_fields .slug.en") { fill_in_name "en_link" }
      select2("pt-BR", from: 'Select locale')
      within("#attr_fields .slug.pt-BR") { fill_in_name "pt-BR_link" }

      click_on "Update"

      visit spree.product_path 'en_link'
      expect(page).to have_text_like 'Product'

      visit '/pt-BR/products/pt-BR_link'
      expect(page).to have_text_like 'Produtos'
    end
  end

  private

  def fill_in_name(value)
    fill_in first("input[type='text']")["name"], with: value
  end
end
