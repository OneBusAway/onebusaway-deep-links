module LayoutsHelper

  # from https://mattbrictson.com/easier-nested-layouts-in-rails
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer)
    output = render(template: File.join("layouts", layout))
    self.output_buffer = ActionView::OutputBuffer.new(output)
  end

  def back_link(title, path)
    @back_link_title = title
    @back_link_path = path
  end

  def sub_tab(name:, path:)
    @sub_tabs ||= []
    @sub_tabs << { name:, path: }
  end
end