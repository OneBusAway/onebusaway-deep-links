require 'rails_helper'

RSpec.describe "Api::V1::SurveyResponses", type: :request do
  let!(:survey) { create(:survey, available: true) }
  let!(:question1) do
    create(:question, survey:, content: QuestionContent.new(type: 'label', label_text: 'hello, world!'))
  end
  let!(:question2) do
    create(:question, survey:, content: QuestionContent.new(type: 'text', label_text: 'name'))
  end
  let!(:question3) do
    create(:question, survey:, content: QuestionContent.new(type: 'text', label_text: 'email'))
  end
  let(:user_identifier) { "abc1234567890" }

  let(:successful_create_post) do
    post api_v1_survey_responses_path, params: {
      survey_id: survey.id,
      user_identifier:,
      responses: [
        {
          question_id: question2.id,
          question_type: question2.content.type,
          question_label: question2.content.label_text,
          answer: 'Alice'
        }
      ].to_json
    }
  end

  # TODO: add tests for available=false

  describe "POST /api/v1/survey_responses" do
    context 'missing survey_id' do
      it 'returns 404' do
        post api_v1_survey_responses_path, params: {
          user_identifier:,
          responses: [].to_json
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'missing user_identifier' do
      it 'returns 404' do
        post api_v1_survey_responses_path, params: {
          survey_id: survey.id,
          responses: [].to_json
        }

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to eq({ "errors" => ["User identifier can't be blank"] })
      end
    end

    context 'successful request' do
      it 'creates a survey response' do
        successful_create_post

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json['survey_response']['id']).to_not be_nil
        expect(json['survey_response']['id']).to eq(SurveyResponse.last.public_identifier)
        expect(json['survey_response']['user_identifier']).to eq(user_identifier)
        expect(json['survey_response']['update_path']).to eq(api_v1_survey_response_path(SurveyResponse.last))

        expected_answer = {
          "answer" => "Alice",
          "question_id" => question2.id,
          "question_label" => "name",
          "question_type" => "text"
        }

        survey_response = SurveyResponse.last
        expect(survey_response.responses.first.as_json).to eq(expected_answer)
      end
    end
  end

  describe "POST /api/v1/survey_responses/:id" do
    it 'succeeds when the survey response exists' do
      successful_create_post

      json = JSON.parse(response.body)
      path = json['survey_response']['update_path']

      post path, params: {
        responses: [
          {
            question_id: question3.id,
            question_type: question3.content.type,
            question_label: question3.content.label_text,
            answer: 'alice@example.com'
          }
        ].to_json
      }

      survey_response = SurveyResponse.last

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json['survey_response']['id']).to eq(survey_response.public_identifier)

      expected_saved_responses = [{ "answer" => "alice@example.com",
                                    "question_id" => question3.id,
                                    "question_label" => "email",
                                    "question_type" => "text" },
                                  { "answer" => "Alice",
                                    "question_id" => question2.id,
                                    "question_label" => "name",
                                    "question_type" => "text" }]

      expect(survey_response.responses.as_json).to match_array(expected_saved_responses)
    end
  end
end
