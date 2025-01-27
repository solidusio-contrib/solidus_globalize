# frozen_string_literal: true

require 'globalize'

module SerializationRails71Globalize6
  def serialize(attr_name, class_name_or_coder = nil, **options)
    self.globalize_serialized_attributes = globalize_serialized_attributes.dup

    if class_name_or_coder.nil?
      globalize_serialized_attributes[attr_name] = options

      super(attr_name, **options)
    elsif class_name_or_coder.is_a?(Hash)
      globalize_serialized_attributes[attr_name] = class_name_or_coder

      # https://github.com/rails/rails/blob/7-2-stable/activerecord/lib/active_record/attribute_methods/serialization.rb#L183
      super(attr_name, **class_name_or_coder)
    else
      globalize_serialized_attributes[attr_name] = [class_name_or_coder, options]

      # this is only needed for ACTIVE_RECORD_71. class_name_or_coder will be removed with Rails 7.2
      # https://github.com/rails/rails/blob/7-1-stable/activerecord/lib/active_record/attribute_methods/serialization.rb#L183
      super(attr_name, class_name_or_coder, **options)
    end
  end

  if Rails.gem_version >= Gem::Version.new('7.1') &&
    Gem.loaded_specs["globalize"]&.version&.public_send(:<, "7")
    Globalize::AttributeMethods::Serialization.prepend(self)
  end
end
