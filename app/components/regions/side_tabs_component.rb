# frozen_string_literal: true

class Regions::SideTabsComponent < ViewComponent::Base
  def initialize(region, context:, current_path:)
    super()
    @region = region
    @context = context
    @current_path = current_path
  end
end
