# frozen_string_literal: true

class Navigation::TabsComponent < ViewComponent::Base
  def initialize(tabs)
    super()
    @tabs = tabs
  end
end
