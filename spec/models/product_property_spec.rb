# encoding: utf-8

module Spree
  RSpec.describe ProductProperty, type: :model do
    context 'when ::ignored_columns include the "value" field' do
      before do
        if described_class.respond_to? :ignored_columns
          described_class.ignored_columns = ['value']
          described_class.reset_column_information
        end
      end

      it 'still validates the "value" field without raising an exception' do
        expect { subject.valid? }.to_not raise_error(NoMethodError)
      end
    end
  end
end
