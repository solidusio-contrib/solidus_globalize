# frozen_string_literal: true

RSpec.describe "Products", :js do
  stub_authorization!
  let!(:product) { create(:product) }
  let!(:store) { create(:store) }

  # Regression Spec: https://github.com/spree/spree_i18n/issues/386
  context "cloning" do
    it "doesnt blow up" do
      visit spree.admin_products_path
      click_icon :copy
      expect(page).to have_selector '.flash', text: 'Product has been cloned', visible: false
    end
  end
end
