class AdminRouteConstraint
  def current_admin(request)
    return if request.cookies["session_token"].blank?

    @current_admin ||= Admin.find_by(session_token: request.cookies["session_token"].to_s)
    
  end

  def admin_logged_in?(request)
    !!current_admin(request)
  end

  def matches?(request)
    admin_logged_in?(request)
  end
end