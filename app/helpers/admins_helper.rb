module AdminsHelper
  def current_admin
    @current_admin ||= Admin.find_by(session_token: cookies[:session_token].to_s) if !cookies[:session_token].blank?
  end

  def current_admin_region
    current_admin&.region
  end

  def admin_logged_in?
    !!current_admin
  end
  
  def admin_required
    return true if admin_logged_in?

    session[:return_to] = request.method == "GET" ? request.path : request.referer
    flash[:notice] = "You must be logged in to do this."
    redirect_to login_path and return false    
  end

  protected

  def set_current_admin(admin)
    if admin.session_token.nil?
      admin.generate_session_token
      admin.save
    end

    @current_admin = admin
    cookies.permanent[:session_token] = admin.session_token
  end

  def logout_admin
    current_admin.session_token = nil
    current_admin.save
    @current_admin = nil
    cookies.delete(:session_token)
  end
end
