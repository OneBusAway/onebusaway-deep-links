module ApplicationHelper
  
  def title(t = nil)
    if t.nil?
      @title
    else
      @title = t
    end
  end
  
  def severity_to_string(sev)
    case sev
    when 2
      return "Info"
    when 3
      return "Warning"
    when 4
      return "Severe"
    else
      return "Unknown"
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
  
  def bootstrap_class_for(flash_type)
      { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
    end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "mt-3 alert #{bootstrap_class_for(msg_type)}", role: "alert") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
end
