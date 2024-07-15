require 'rails_helper'

RSpec.describe SurveyResponse, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      survey_response = build(:survey_response)
      expect(survey_response).to be_valid
    end

    it 'is not valid without a user_identifier' do
      survey_response = build(:survey_response, user_identifier: nil)
      expect(survey_response).not_to be_valid
    end

    it 'is not valid without a public_identifier' do
      survey_response = build(:survey_response, public_identifier: nil)
      expect(survey_response).not_to be_valid
    end
  end

  describe '#upsert_responses' do
    let(:survey_response) { create(:survey_response) }
    let(:new_responses) do
      [
        SurveyResponseContent.new(question_id: 1, answer: 'Answer 1'),
        SurveyResponseContent.new(question_id: 2, answer: 'Answer 2')
      ]
    end

    context 'when there are no existing responses' do
      it 'adds all new responses' do
        survey_response.upsert_responses(new_responses)
        expect(survey_response.responses.size).to eq(2)
      end
    end

    context 'when updating existing responses' do
      it 'replaces the existing response with the same question_id' do
        existing_responses = [SurveyResponseContent.new(question_id: 1, answer: 'Old Answer')]
        survey_response.responses = existing_responses
        survey_response.upsert_responses(new_responses)
        expect(survey_response.responses.find { |r| r.question_id == 1 }.answer).to eq('Answer 1')
      end
    end

    context 'when adding new responses alongside existing ones' do
      it 'keeps existing responses and adds new ones' do
        existing_responses = [SurveyResponseContent.new(question_id: 3, answer: 'Existing Answer')]
        survey_response.responses = existing_responses
        survey_response.upsert_responses(new_responses)
        expect(survey_response.responses.size).to eq(3)
      end
    end
  end

  describe '#upsert_responses!' do
    let(:survey_response) { create(:survey_response) }
    let(:new_responses) do
      [
        SurveyResponseContent.new(question_id: 1, answer: 'Answer 1'),
        SurveyResponseContent.new(question_id: 2, answer: 'Answer 2')
      ]
    end

    it 'saves the changes to the database' do
      survey_response.upsert_responses!(new_responses)
      survey_response.reload
      expect(survey_response.responses.size).to eq(2)
    end
  end
end
