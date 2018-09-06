class ApplicationController < ActionController::Base
  include AdminsHelper
  include StatsHelper

  protect_from_forgery with: :exception
  
  protected
  
  def render_not_found_response(ex)
    render json: { error: ex.message }, status: :not_found
  end
end
