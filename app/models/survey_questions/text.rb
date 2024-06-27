class SurveyQuestions::Text
  include StoreModel::Model

  attribute :label, SurveyQuestions::Label.to_type

  def to_h
    {
      type: 'text',
      label: label.to_h
    }
  end
end