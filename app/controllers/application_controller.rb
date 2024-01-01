class ApplicationController < ActionController::Base
  include AdminsHelper
  include StatsHelper

  protect_from_forgery with: :exception

  protected

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end
  end

  def render_not_found_response(ex)
    render json: { error: ex.message }, status: :not_found
  end
end
