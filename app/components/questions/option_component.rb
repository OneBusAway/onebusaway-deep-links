# frozen_string_literal: true

class Questions::OptionComponent < ViewComponent::Base
  def initialize(key:, value: "")
    super()
    @key = key
    @value = value
  end
end
