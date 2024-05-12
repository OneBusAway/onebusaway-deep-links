# frozen_string_literal: true

class Tables::ColumnComponent < ViewComponent::Base
  def initialize(text)
    super()
    @text = text
  end
end
