# frozen_string_literal: true

class Containers::EmptyStateComponent < ViewComponent::Base
  def initialize(title:, description:)
    super()
    @title = title
    @description = description
  end
end
