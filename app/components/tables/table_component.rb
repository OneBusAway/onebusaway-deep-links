# frozen_string_literal: true

class Tables::TableComponent < ViewComponent::Base
  renders_many :columns, Tables::ColumnComponent
  renders_one :tbody
end
