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
  end
end