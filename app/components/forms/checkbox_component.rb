# frozen_string_literal: true

class Forms::CheckboxComponent < ViewComponent::Base
  def initialize(form:, method:, help_text: nil, input_html: {}, **options)
    super()
    @form = form
    @method = method
    @help_text = help_text
    @input_html = input_html
    @options = options || {}
  end
end
