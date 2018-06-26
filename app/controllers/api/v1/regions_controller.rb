class Api::V1::RegionsController < Api::V1::ApiController
  skip_before_action :load_region, only: [:index]

  def index
    @regions = Region.all
    respond_to do |format|
      format.json
    end
  end
end
