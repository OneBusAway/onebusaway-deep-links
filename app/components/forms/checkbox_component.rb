# frozen_string_literal: true

class Forms::CheckboxComponent < ViewComponent::Base
  def initialize(form:, method:, help_text: nil, **options)
    super()
    @form = form
    @method = method
    @help_text = help_text
    @options = options || {}
  end
end
