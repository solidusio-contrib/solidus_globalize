Spree::Validations::DbMaximumLengthValidator.class_eval do
  def validate(record)
    field = @field.to_sym
    limit = record.column_for_attribute(field).limit
    value = record[field]
    if value && limit && value.to_s.length > limit
      record.errors.add(field, :too_long, count: limit)
    end
  end
end
