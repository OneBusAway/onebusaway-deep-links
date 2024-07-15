class SurveyResponseContent
  include StoreModel::Model

  attribute :question_id, :integer
  attribute :question_type, :string
  attribute :question_label, :string
  attribute :answer, :string
end