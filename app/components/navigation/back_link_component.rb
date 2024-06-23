# frozen_string_literal: true

class Navigation::BackLinkComponent < ViewComponent::Base
  def initialize(title:, link:)
    super()
    @title = title
    @link = link
  end
end
