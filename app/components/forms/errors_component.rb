# frozen_string_literal: true

class Forms::ErrorsComponent < ViewComponent::Base
  def initialize(errors:)
    super()
    @errors = errors
  end

  def render?
    @errors.any?
  end
end
