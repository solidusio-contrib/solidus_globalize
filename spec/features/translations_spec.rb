# encoding: utf-8
RSpec.feature "Translations" do
  background do
    reset_spree_preferences
    allow_any_instance_of(Spree::Store)
      .to receive(:available_locales) { [:en, :'pt-BR'] }
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
        ]
      )
    end

    before do
      I18n.locale = 'pt-BR'
      allow_any_instance_of(Spree::Store)
        .to receive(:available_locales) { [:'pt-BR'] }
    end

    scenario 'displays translated product page' do
      visit '/pt-BR/products/antimatter'
      expect(page.title).to have_content('Antimatéria')
    end

    scenario 'displays translated products list' do
      visit '/pt-BR/products'
      expect(page).to have_content('Antimatéria')
    end

    after do
      I18n.locale = :en
    end
  end
end
