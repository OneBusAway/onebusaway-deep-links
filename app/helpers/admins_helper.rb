module AdminsHelper
  def current_admin
    @current_admin ||= Admin.find_by(session_token: cookies[:session_token].to_s) if !cookies[:session_token].blank?
  end

  def admin_logged_in?
    !!current_admin
  end
  
  def admin_required
    return true if admin_logged_in?
    session[:return_to] = request.method == "GET" ? request.path : request.referer
    flash[:notice] = "You must be logged in to do this."
    redirect_to admin_login_path and return false    
  end

  protected

  def set_current_admin(admin)
    if admin && admin.session_token
      @current_admin = admin
      cookies.permanent[:session_token] = admin.session_token
    else
      @current_admin = nil
      cookies.delete(:session_token)
    end
  end

  def logout_admin
    current_admin.session_token = nil
    current_admin.save
    set_current_admin(nil)    
  end
end
