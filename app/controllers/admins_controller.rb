class AdminsController < ApplicationController
  before_action :admin_required, except: [:new_session, :create_session, :activate]
  
  def new_session
  end
  
  def create_session
    admin = Admin.find_by(email: params[:email].downcase)
    if admin && admin.authenticate(params[:password])
      set_current_admin(admin)
      redirect_to admin_path, notice: "You are now logged in"
    else
      flash.now.alert = "Unable to log in. Check your email and password and try again"
      render :new
    end
  end
  
  def activate
    @admin = Admin.find_by(reset_digest: params[:code])
    
    if @admin.nil?
      flash[:error] = "Unable to log in. Contact support if this issue persists."
      redirect_to(root_path) and return
    end
    
    sent_at = @admin.reset_sent_at
    
    @admin.reset_digest = nil
    @admin.reset_sent_at = nil
    @admin.save!
    
    if sent_at < 2.hours.ago
      flash[:error] = "Please request a new code by contacting support."
      redirect_to(root_path) and return
    end
    
    set_current_admin(@admin)
    
    redirect_to reset_password_admin_path, notice: "Add a strong new password to your account."
  end
  
  def reset_password
    @admin = current_admin
  end
  
  def update
    @admin = current_admin
    
    if @admin.update(permitted_params)
      redirect_to admin_path, notice: "Your account has been updated."
    else
      render 'reset_password'
    end
  end
  
  def destroy_session
    logout_admin
    redirect_to root_path, notice: "You are now logged out."
  end
  
  def show
    @admin = current_admin
    @region = @admin.region
  end
  
  protected
  
  def permitted_params
    params.require(:admin).permit(:password, :password_confirmation)
  end
end
