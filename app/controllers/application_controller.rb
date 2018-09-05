class ApplicationController < ActionController::Base
  include AdminsHelper
  include StatsHelper

  protect_from_forgery with: :exception
end
