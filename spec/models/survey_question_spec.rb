require 'rails_helper'

RSpec.describe SurveyQuestion, type: :model do
  let(:study_invite) { create(:study_invite) }
  let(:survey_question) { create(:survey_question, study_invite:) }

  describe 'content attribute' do
    it 'defaults to a new Label question' do
      new_question = SurveyQuestion.new
      expect(new_question.content).to be_a(SurveyQuestionContent)
    end
  end
end