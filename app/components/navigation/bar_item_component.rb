# frozen_string_literal: true

class Navigation::BarItemComponent < ViewComponent::Base
  def initialize(title:, path:, current_path:)
    super()
    @title = title
    @path = path
    @current_path = current_path
  end

  def active?
    @current_path == @path
  end
end
