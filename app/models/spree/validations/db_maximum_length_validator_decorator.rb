module Spree
  module Validations
    class DbMaximumLengthValidator < ActiveModel::Validator
      def validate(record)
        limit = record.column_for_attribute(@field.to_sym).limit
        value = record[@field.to_sym]
        if value && limit && value.to_s.length > limit
          record.errors.add(@field.to_sym, :too_long, count: limit)
        end
      end
    end
  end
end
