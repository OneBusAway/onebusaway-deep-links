class Admins::AlertsController < ApplicationController
  include AlertFeedItemsConcerns
  before_action :admin_required

  def index
    @region = current_admin.region
    @items = load_index_data(@region)
  end
end
