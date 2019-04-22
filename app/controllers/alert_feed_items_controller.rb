class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns
  before_action :admin_required, except: [:index, :items]

  def index
    # # :-\ this is the result of a dumb decision i made here:
    # # https://github.com/OneBusAway/onebusaway-deep-links/commit/8df90ceb7367e78ebe489421ac268b663dca69d9
    # # now I need to hack around it by keeping this action as-is for backwards compatibility reasons for now.
    # request.format = :json
    #
    # @region = Region.find_by(region_identifier: params[:region_id])
    # @items = load_index_data(@region, true)
    #
    # respond_to do |format|
    #   format.json
    # end

    render json: []
  end

  def items
    @region = Region.find_by(region_identifier: params[:region_id])
    @items = load_index_data(@region)
    respond_to do |format|
      format.html { render(layout: 'regions') }
    end
  end

  def create
    @manual_feed = current_admin.region.manual_feed

    if @manual_feed.nil?
      redirect_to admin_path, error: "No manual feed has been created for #{current_admin.region.name} yet"
      return
    end

    # Create the item
    item = @manual_feed.alert_feed_items.build(permitted_params)
    item.external_id = item.url
    item.starts_at    = DateTime.now
    item.priority     = AlertFeedItem::HIGH_PRIORITY
    item.save!

    # Poke the record's 'updated at' timestamp
    @manual_feed.fetch()

    # @manual_feed.add_alert_item(permitted_params[:title], permitted_params[:summary], permitted_params[:url], params[:test_item])

    redirect_to admin_alerts_path, notice: "Added alert to manual feed."
  end

  def edit
    @item = AlertFeedItem.find(params[:id])
  end

  def update
    @item = AlertFeedItem.find(params[:id])
    if @item.update_attributes(permitted_params)
      redirect_to admin_alerts_path, note: "Updated alert feed item: #{@item.title}."
    else
      render :edit
    end
  end

  def destroy
    @item = AlertFeedItem.find(params[:id])
    @item.destroy
    redirect_to admin_alerts_path, note: "Deleted alert feed item: #{@item.title}."
  end

  protected

  def permitted_params
    params.require(:alert_feed_item).permit(:title, :summary, :url, :cause, :effect, :test_item)
  end
end