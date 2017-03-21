Spree::Variant.class_eval do
  has_one :product_translation, through: :product, source: :translations
  self.whitelisted_ransackable_associations << 'product_translation'
end
