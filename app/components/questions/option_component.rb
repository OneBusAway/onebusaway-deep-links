# frozen_string_literal: true

class Questions::OptionComponent < ViewComponent::Base
  def initialize(value = "")
    super()
    @value = value
  end
end
