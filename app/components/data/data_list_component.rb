# frozen_string_literal: true

class Data::DataListComponent < ViewComponent::Base
  def initialize(items)
    super()
    @items = items
  end
end
