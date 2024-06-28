require 'rails_helper'

RSpec.describe "Admins::SurveyQuestions", type: :request do
  let(:region) { create(:region) }
  let(:admin) { create(:admin, region:) }
  let(:study) { create(:study, region:) }
  let(:study_invite) { create(:study_invite, study:) }

  describe "POST /admin/studies/:study_id/study_invites/:study_invite_id/survey_questions" do
    context "label 'question'" do
      it "creates the question" do
        sign_in admin
        post admin_study_study_invite_survey_questions_path(study, study_invite),
             params: {
               survey_question: { content_attributes: { type: 'label', label_text: 'Question' } }
             }

        q = SurveyQuestion.last
        expect(q.content).to be_a(SurveyQuestionContent)
        expect(q.content.label_text).to eq('Question')
      end
    end
  end
end
