class Api::V1::RegionsController < Api::V1::ApiController
  
  def index
    @regions = Region.all
    respond_to do |format|
      format.json
    end
  end
end
