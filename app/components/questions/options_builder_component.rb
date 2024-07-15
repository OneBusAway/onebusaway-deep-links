# frozen_string_literal: true

class Questions::OptionsBuilderComponent < ViewComponent::Base
  def initialize(options:)
    super()
    @options = options
  end
end
