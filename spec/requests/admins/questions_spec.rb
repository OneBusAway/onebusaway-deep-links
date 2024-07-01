require 'rails_helper'

RSpec.describe "Admins::Questions", type: :request do
  let(:region) { create(:region) }
  let(:admin) { create(:admin, region:) }
  let(:study) { create(:study, region:) }
  let(:survey) { create(:survey, study:) }

  describe "POST /admin/studies/:study_id/surveys/:survey_id/questions" do
    context "label 'question'" do
      it "creates the question" do
        sign_in admin
        post admin_study_survey_questions_path(study, survey),
             params: {
               question: { content_attributes: { type: 'label', label_text: 'Question' } }
             }

        q = Question.last
        expect(q.content).to be_a(QuestionContent)
        expect(q.content.label_text).to eq('Question')
      end
    end
  end
end
