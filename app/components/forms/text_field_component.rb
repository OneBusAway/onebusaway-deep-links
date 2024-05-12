# frozen_string_literal: true

class Forms::TextFieldComponent < ViewComponent::Base
  def initialize(form:, method:, **options)
    super()
    @form = form
    @method = method
    @options = options || {}
  end
end
