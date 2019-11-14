# frozen_string_literal: true

module Spree
  RSpec.describe ProductsController, type: :controller do
    include_context 'with pt-BR locale file in place'

    before do
      SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR']
    end

    context "visit non translated product page via permalink on url" do
      let!(:product) { create(:product) }

      it "displays pages successfully" do
        get :show, params: { id: product.slug, locale: 'pt-BR' }
        expect(response).to be_success
      end
    end
  end
end
