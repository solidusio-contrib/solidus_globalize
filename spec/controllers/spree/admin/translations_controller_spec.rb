module Spree
  RSpec.describe Admin::TranslationsController, type: :controller do
    let!(:product) { create(:product) }

    context 'as a full admin' do
      stub_authorization!

      it 'displays page successfully' do
        spree_get :index, { resource: 'products', resource_id: product.slug }
        expect(response).to be_success
      end
    end

    context 'as a limited admin' do
      context 'when I cannot manage products' do
        stub_authorization! do |_|
          cannot :manage, Spree::Product
        end

        it 'redirect to authorization failure' do
          spree_get :index, { resource: 'products', resource_id: product.slug }
          expect(response).to redirect_to spree.unauthorized_path
        end
      end

      context 'when I can manage products' do
        stub_authorization! do |_|
          can :manage, Spree::Product
        end

        it 'displays page successfully' do
          spree_get :index, { resource: 'products', resource_id: product.slug }
          expect(response).to be_success
        end
      end
    end
  end
end
