module ApplicationHelper
  
  def title(t = nil)
    if t.nil?
      @title
    else
      @title = t
    end
  end
  
  def value_or_blank_rep(val)
    if val.blank?
      "—"
    else
      val
    end
  end
  
  def fluid_container(fluid = nil)
    if fluid.nil?
      @use_fluid_container || false
    else
      @use_fluid_container = fluid
    end
  end
  
  def link_to_list_group_item(title, path)
    classes = %w(list-group-item list-group-item-action)
    classes << 'active' if current_page?(path)
    link_to(title, path, class: classes.join(' '))
  end
end
