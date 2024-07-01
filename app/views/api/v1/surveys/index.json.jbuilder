json.array! @surveys do |survey|
  json.extract! survey, :id, :name, :created_at

  json.study do
    json.extract! survey.study, :id, :name, :description
  end

  json.questions do
    json.array! survey.questions do |question|
      json.extract! question, :id, :position, :content
    end
  end
end

