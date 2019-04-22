class Admins::AlertsController < ApplicationController
  include AlertFeedItemsConcerns
  before_action :admin_required

  layout 'admins'

  def index
    @items = load_index_data(current_admin.region)
  end
end
