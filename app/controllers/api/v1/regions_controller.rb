class Api::V1::RegionsController < Api::V1::ApiController
  
  def index
    render json: ["woot"]
  end
end
