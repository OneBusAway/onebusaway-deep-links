require 'rails_helper'

RSpec.describe "Alarms", type: :request do
  describe "GET /alarms" do
    it "works! (now write some real specs)" do
      get alarms_index_path
      expect(response).to have_http_status(200)
    end
  end
end
