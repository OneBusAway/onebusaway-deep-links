require 'rails_helper'

describe Api::V1::RegionsController, type: :request do
  describe "GET /api/v1/regions" do

    before { get('/api/v1/regions', headers: { 'Accept': 'application/json' }) }

    it 'has HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it "returns a list of regions" do
      json = JSON.parse(response.body)
      expect(json).to eq(["woot"])
    end
  end
end

# RSpec.describe "Widget management", :type => :request do
#
#   it "creates a Widget" do
#     headers = {
#       "ACCEPT" => "application/json",     # This is what Rails 4 accepts
#       "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
#     }
#     post "/widgets", :params => { :widget => {:name => "My Widget"} }, :headers => headers
#
#     expect(response.content_type).to eq("application/json")
#     expect(response).to have_http_status(:created)
#   end
#
# end