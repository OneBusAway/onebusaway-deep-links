class Question < ApplicationRecord
  belongs_to :survey
  positioned(on: :survey)

  # survey question content
  include StoreModel::NestedAttributes

  attribute :content, QuestionContent.to_type
  accepts_nested_attributes_for :content, allow_destroy: true

  after_initialize do
    if new_record? && !content&.has_content?
      self.content = QuestionContent.new(type: 'text')
    end
  end
end


