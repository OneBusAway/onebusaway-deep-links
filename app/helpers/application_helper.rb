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

  def local_time(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S %Z")
  end
end
