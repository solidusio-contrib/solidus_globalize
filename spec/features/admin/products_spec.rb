RSpec.feature "Products", :js do
  stub_authorization!
  given!(:product) { create(:product) }
  given!(:store) { create(:store) }

  # Regression Spec: https://github.com/spree/spree_i18n/issues/386
  context "cloning" do
    scenario "doesnt blow up" do
      visit spree.admin_products_path
      click_icon :copy
      expect(page).to have_selector '.flash', text: 'Product has been cloned', visible: false
    end
  end
end
