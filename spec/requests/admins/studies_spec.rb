require 'rails_helper'

RSpec.describe "Admins::Studies", type: :request do
  let(:region) { create(:region) }
  let(:admin) { create(:admin, region:, password: "password") }
  let!(:study) { create(:study, region:, name: "yes, correct study") }
  let!(:other_study) { create(:study) }

  describe "GET /index" do
    it "returns a successful response" do
      sign_in(admin)
      get admin_studies_path
      expect(response.body).to include("yes, correct study")
    end

    it "returns the correct studies for the current admin region" do
      sign_in(admin)
      get admin_studies_path
      expect(assigns(:studies)).to match_array([study])
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      sign_in(admin)
      get admin_study_path(study)
      expect(response).to be_successful
    end

    it "returns a 404 response when the study is not in the current admin region" do
      sign_in(admin)
      get admin_study_path(other_study)
      expect(response).to be_not_found
    end
  end

  describe "POST /create" do
    it "creates a new study" do
      sign_in(admin)
      expect {
        post admin_studies_path, params: { study: attributes_for(:study) }
      }.to change(Study, :count).by(1)
    end

    it "redirects to the studies list" do
      sign_in(admin)
      post admin_studies_path, params: { study: attributes_for(:study) }
      expect(response).to redirect_to(admin_studies_path)
    end
  end

  describe "PUT /update" do
    it "updates the requested study" do
      sign_in(admin)
      put admin_study_path(study), params: { study: { name: 'New Name' } }
      study.reload
      expect(study.name).to eq('New Name')
    end

    it "redirects to the studies list" do
      sign_in(admin)
      put admin_study_path(study), params: { study: { name: 'New Name' } }
      expect(response).to redirect_to(admin_studies_path)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested study" do
      sign_in(admin)
      delete admin_study_path(study)
      expect(Study.exists?(study.id)).to be_falsy
    end

    it "redirects to the studies list" do
      sign_in(admin)
      delete admin_study_path(study)
      expect(response).to redirect_to(admin_studies_path)
    end
  end
end