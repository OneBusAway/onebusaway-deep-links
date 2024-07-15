class Question < ApplicationRecord
  belongs_to :survey
  positioned(on: :survey)

  # survey question content
  include StoreModel::NestedAttributes

  before_save do
    content.prune
  end

  attribute :content, QuestionContent.to_type
  accepts_nested_attributes_for :content, allow_destroy: true

  after_initialize do
    self.content = QuestionContent.new(type: 'text') if new_record? && !content&.has_content?
  end
end


