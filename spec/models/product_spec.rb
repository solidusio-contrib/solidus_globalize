# frozen_string_literal: true

module Spree
  RSpec.describe Product, type: :model do
    let(:product) { create(:product) }
    let(:taxon) { create(:taxon) }

    # Regression test for #309
    it "duplicates translations" do
      original_count = product.translations.count
      new_product = product.duplicate
      expect(new_product.translations).not_to be_blank
      expect(product.translations.count).to eq original_count
    end

    # Regression test for #433
    it "allow saving a product with taxons" do
      product.taxons << taxon
      expect(product.taxons).to include(taxon)
    end

    it "handle translation in ransack" do
      result = described_class.ransack(name_cont: product.name[0..2]).result
      expect(result.first).to eq product

      result = described_class.search(name_cont: product.name[0..2]).result
      expect(result.first).to eq product
    end

    # Regression tests for #466
    describe ".like_any" do
      context "allow searching products through their translations" do
        before do
          I18n.locale = :"zh-CN"
        end

        it "with name" do
          product.translations.create locale: "zh-CN",
            name: "创意马克杯",
            description: "<p>一流工程师设计制造手工艺品</p>",
            meta_description: '顶尖工艺设计',
            meta_keywords: '工艺品'

          expect(described_class.like_any([:name], ['创意'])).to include(product)
        end

        it "with name or description" do
          product.translations.create locale: "zh-CN",
            name: "创意马克杯",
            description: "<p>一流工程师设计制造手工艺品</p>",
            meta_description: '顶尖工艺设计',
            meta_keywords: '工艺品'

          expect(described_class.like_any([:name, :description], ['手工艺品'])).to include(product)
        end
      end
    end

    context "when soft-deleting" do
      subject(:soft_deleting) do
        product.discard
        product.reload
      end

      it 'keeps the core discard callbacks' do
        expect(product.variants_including_master.kept.size).to eq 1
        expect(product.variants_including_master.with_discarded.size).to eq 1

        soft_deleting

        expect(product.variants_including_master.kept.size).to eq 0
        expect(product.variants_including_master.with_discarded.size).to eq 1
      end

      it "keeps the translation on deletion" do
        soft_deleting
        expect(product.translations).not_to be_empty
      end

      it "changes the slug on the translation to allow reuse of original slug" do
        expect do
          soft_deleting
        end.to change(product, :slug)
      end
    end
  end
end
