class ApplicationController < ActionController::Base
  include AdminsHelper
  protect_from_forgery with: :exception
end
