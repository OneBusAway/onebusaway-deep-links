require 'rails_helper'

RSpec.describe "Admins::StudyInvites", type: :request do
  let(:region) { create(:region) }
  let(:admin) { create(:admin, region:) }
  let(:study) { create(:study, region:) }

  describe "GET /new" do
    before { sign_in(admin) }
    it "returns a successful response" do
      get new_admin_study_study_invite_path(study)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { sign_in(admin) }

    it "creates a new study invite" do
      sign_in(admin)

      # force the creation of a study invite
      expect(study.study_invites.count).to eq(1)

      expect {
        post admin_study_study_invites_path(study), params: { study_invite: attributes_for(:study_invite) }
      }.to change(StudyInvite, :count).by(1)
    end

    it "redirects to the study invite" do
      post admin_study_study_invites_path(study), params: { study_invite: attributes_for(:study_invite) }
      expect(response).to redirect_to(admin_study_study_invite_path(study, StudyInvite.last))
    end
  end

  describe "GET /edit" do
    before { sign_in(admin) }

    it "returns a successful response" do
      get edit_admin_study_study_invite_path(study, study.study_invites.first)
      expect(response).to be_successful
    end
  end

  describe "PUT /update" do
    before { sign_in(admin) }

    it "updates the requested study invite" do
      study_invite = study.study_invites.first
      put admin_study_study_invite_path(study, study_invite), params: { study_invite: { name: 'New Name' } }
      study_invite.reload
      expect(study_invite.name).to eq('New Name')
    end

    it "redirects to the study invite" do
      study_invite = study.study_invites.first
      put admin_study_study_invite_path(study, study_invite), params: { study_invite: { name: 'New Name' } }
      expect(response).to redirect_to(admin_study_study_invite_path(study, study_invite))
    end
  end

  describe "DELETE /destroy" do
    before { sign_in(admin) }

    let!(:study_invite) { create(:study_invite, study:) }

    it "destroys the requested study invite" do
      expect {
        delete admin_study_study_invite_path(study, study_invite)
      }.to change(StudyInvite, :count).by(-1)
    end

    it "redirects to the study" do
      delete admin_study_study_invite_path(study, study_invite)
      expect(response).to redirect_to(admin_study_path(study))
    end
  end
end