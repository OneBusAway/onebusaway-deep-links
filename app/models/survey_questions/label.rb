class SurveyQuestions::Label
  include StoreModel::Model

  attribute :text, :string

  def to_h
    {
      type: 'label',
      text:
    }
  end
end