class Question < ApplicationRecord
  belongs_to :survey
  positioned(on: :survey)

  # survey question content
  include StoreModel::NestedAttributes

  before_validation :set_required_param
  before_save do
    content.prune
  end

  attribute :content, QuestionContent.to_type
  accepts_nested_attributes_for :content, allow_destroy: true

  after_initialize do
    self.content = QuestionContent.new(type: 'text') if new_record? && !content&.has_content?
  end
  
  private

  def set_required_param
    self.required = false if %w[external_survey label].include?(content&.type)
  end
end


