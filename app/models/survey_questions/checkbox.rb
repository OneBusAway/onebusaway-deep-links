class SurveyQuestions::Checkbox
  include StoreModel::Model

  attribute :label, SurveyQuestions::Label.to_type
  attribute :options, array: true, default: []

  def to_h
    {
      type: 'checkbox',
      label: label.to_h,
      options:
    }
  end
end