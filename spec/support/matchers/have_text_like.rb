# frozen_string_literal: true

def have_text_like(expected)
  have_text(/#{Regexp.quote(expected)}/iu)
end
