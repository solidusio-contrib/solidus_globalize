# frozen_string_literal: true

shared_context "behaves as translatable" do
  testable_attributes = [:name, :value]
  attribute = nil

  before do
    subject.attribute_names.each do |a|
      if testable_attributes.include? a.to_sym
        attribute = a.to_sym
      end
    end
  end

  context "when there's a missing translation" do
    let!(:model) { subject.class.new }

    before do
      SolidusGlobalize::Config.supported_locales = [:en, :es]
      SolidusGlobalize::Fallbacks.config!

      model[attribute] = 'English'
    end

    it "falls back to default locale" do
      I18n.locale = :es
      expect(model[attribute]).to eq "English"
    end
  end

  context "when translation is missing on default locale" do
    let!(:model) { subject.class.new }

    before do
      I18n.locale = :es
      SolidusGlobalize::Config.supported_locales = [:en, :es, :de]
      SolidusGlobalize::Fallbacks.config!

      model[attribute] = 'produto'
    end

    it "falls back to not default translations" do
      I18n.locale = :en
      expect(model[attribute]).to eq "produto"
    end
  end

  context "when translation is missing on locale other than default" do
    let!(:model) { subject.class.new }

    before do
      SolidusGlobalize::Config.supported_locales = [:es, :en, :de]
      SolidusGlobalize::Fallbacks.config!

      model[attribute] = 'product'
    end

    it "falls back to default locale first" do
      I18n.locale = :es
      model[attribute] = "produto"

      I18n.locale = :de
      expect(model[attribute]).to eq "product"
    end
  end
end
