class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
end