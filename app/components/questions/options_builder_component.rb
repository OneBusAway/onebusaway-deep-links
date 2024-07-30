# frozen_string_literal: true

class Questions::OptionsBuilderComponent < ViewComponent::Base
  def initialize(options:, label: nil, option_name: nil)
    super()
    @label = label.presence || 'Options'
    @option_name = option_name.presence || 'options'
    @options = options
  end
end
