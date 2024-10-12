require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:survey) { create(:survey) }
  let(:question) { create(:question, survey:) }

  describe 'content attribute' do
    it 'defaults to a new Label question' do
      new_question = Question.new
      expect(new_question.content).to be_a(QuestionContent)
    end
  end

  describe 'required' do
    it 'defaults to true' do
      new_question = Question.new
      expect(new_question.required).to be true
    end

    it 'is false for external_survey type' do
      new_question = Question.new(
        survey:,
        content: QuestionContent.new(
          type: 'external_survey',
          label_text: 'Sample Label',
          survey_provider: 'Provider',
          url: 'http://example.com',
          sdk_configuration_values: [],
          embedded_data_fields: []
        )
      )
      new_question.valid?
      expect(new_question.required).to be false
    end

    it 'is false for label type' do
      new_question = Question.new(
        survey:,
        content: QuestionContent.new(type: 'label', label_text: 'Sample Label')
      )
      new_question.valid?
      expect(new_question.required).to be false
    end
  end
end