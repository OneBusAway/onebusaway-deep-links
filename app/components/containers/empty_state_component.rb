# frozen_string_literal: true

class Containers::EmptyStateComponent < ViewComponent::Base
  def initialize(title:, description:, icon: nil)
    super()
    @title = title
    @description = description
    @icon = icon
  end
end
