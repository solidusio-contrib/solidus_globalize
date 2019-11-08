module Spree
  RSpec.describe ProductsController, type: :controller do
    let!(:product) { create(:product) }

    before do
      allow_any_instance_of(Spree::Store)
        .to receive(:available_locales) { [:'pt-BR'] }
    end

    context "visit non translated product page via permalink on url" do
      it "displays pages successfully" do
        get :show, params: { id: product.slug, locale: 'pt-BR' }
        expect(response).to be_success
      end
    end
  end
end
