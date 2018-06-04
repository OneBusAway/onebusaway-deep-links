module ApplicationHelper
  
  def title(t = nil)
    if t.nil?
      @title
    else
      @title = t
    end
  end
end
