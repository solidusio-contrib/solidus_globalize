# frozen_string_literal: true

RSpec.describe "Translations" do
  include_context 'with pt-BR locale file in place'
  before do
    SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR']
  end

  context 'product' do
    let!(:product) do
      create(:product,
        name: 'Antimatter',
        translations: [
          Spree::Product::Translation.new(
            locale: 'pt-BR',
            name: 'Antimatéria'
          )
        ])
    end

    before do
      I18n.locale = 'pt-BR'
    end

    it 'displays translated product page' do
      visit '/pt-BR/products/antimatter'
      expect(page.title).to have_content('Antimatéria')
    end

    it 'displays translated products list' do
      visit '/pt-BR/products'
      expect(page).to have_content('Antimatéria')
    end
  end
end
