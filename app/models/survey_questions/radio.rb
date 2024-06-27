class SurveyQuestions::Radio
  include StoreModel::Model

  attribute :label, SurveyQuestions::Label.to_type
  attribute :options, array: true, default: []

  def to_h
    {
      type: 'radio',
      label: label.to_h,
      options:
    }
  end
end