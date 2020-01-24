# frozen_string_literal: true

module Spree
  RSpec.describe Admin::TranslationsController, type: :controller do
    let!(:product) { create(:product) }

    context 'as a full admin' do
      stub_authorization!

      it 'displays page successfully' do
        get :index, params: { resource: 'products', resource_id: product.slug }
        expect(response).to have_http_status(:success)
      end
    end

    context 'as a limited admin' do
      context 'when I cannot manage products' do
        stub_authorization! do |_|
          cannot :manage, Spree::Product
        end

        it 'redirect to authorization failure' do
          get :index, params: { resource: 'products', resource_id: product.slug }
          expect(response).to redirect_to '/unauthorized'
        end
      end

      context 'when I can manage products' do
        stub_authorization! do |_|
          can :manage, Spree::Product
        end

        it 'displays page successfully' do
          get :index, params: { resource: 'products', resource_id: product.slug }
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
