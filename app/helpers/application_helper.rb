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
end
