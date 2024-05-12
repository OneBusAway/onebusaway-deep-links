# frozen_string_literal: true

class Admin::SideTabsComponent < ViewComponent::Base
  def initialize(context:, current_path:)
    super()
    @context = context
    @current_path = current_path
  end
end
