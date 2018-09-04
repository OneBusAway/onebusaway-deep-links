class SessionsController < ApplicationController
  before_action :admin_required, except: [:new, :create]
  
  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      set_current_admin(admin)
      redirect_to admin_path, notice: "You are now logged in"
    else
      flash.now.alert = "Unable to log in. Check your email and password and try again"
      render :new
    end
  end
  
  def destroy
    logout_admin
    redirect_to root_path, notice: "You are now logged out"
  end
end
