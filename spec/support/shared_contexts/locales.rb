# frozen_string_literal: true

shared_context 'pt-BR locale' do
  before do
    I18n.backend.store_translations(:'pt-BR', spree: {
                                      i18n: { this_file_language: "Português brasileiro" },
                                    })
  end

  after do
    # Reset locale after each spec.
    I18n.locale = :en
    I18n.reload!
  end
end
