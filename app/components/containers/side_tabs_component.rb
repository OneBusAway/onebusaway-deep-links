# frozen_string_literal: true

class Containers::SideTabsComponent < ViewComponent::Base
  renders_many :tabs, ->(title:, path:, active: false) do
    link_to(
      title,
      path,
      class: class_names(
        "group flex gap-x-3 rounded-md p-2 pl-3 text-sm leading-6 font-semibold",
        {
          "bg-gray-50 text-brand-tertiary": active,
          "text-gray-700 hover:text-brand-tertiary hover:bg-gray-50": !active
        }
      )
    )
  end
end
