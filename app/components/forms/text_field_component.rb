# frozen_string_literal: true

class Forms::TextFieldComponent < ViewComponent::Base
  def initialize(form:, method:, input_html: {}, **options)
    super()
    @form = form
    @method = method
    @input_html = input_html
    @options = options || {}
  end
end
