# frozen_string_literal: true

class Forms::ButtonBarComponent < ViewComponent::Base
  def initialize(form)
    super()
    @form = form
  end
end
