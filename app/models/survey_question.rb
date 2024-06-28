class SurveyQuestion < ApplicationRecord
  belongs_to :study_invite
  positioned(on: :study_invite)

  # survey question content
  include StoreModel::NestedAttributes

  attribute :content, SurveyQuestionContent.to_type
  accepts_nested_attributes_for :content, allow_destroy: true

  after_initialize do
    if new_record? && !content&.has_content?
      self.content = SurveyQuestionContent.new(type: 'text')
    end
  end
end


