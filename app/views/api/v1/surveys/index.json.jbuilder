json.surveys do
  json.array! @surveys do |survey|
    json.extract! survey, :id, :name, :created_at, :updated_at, :show_on_map, :show_on_stops

    if survey.visible_stop_list.blank?
      json.visible_stop_list nil
    else
      json.visible_stop_list survey.visible_stop_list&.split(',')&.map(&:strip)
    end

    if survey.visible_route_list.blank?
      json.visible_route_list nil
    else
      json.visible_route_list survey.visible_route_list&.split(',')&.map(&:strip)
    end

    json.study do
      json.extract! survey.study, :id, :name, :description
    end

    json.questions do
      json.array! survey.questions do |question|
        json.extract! question, :id, :position
        json.content do
          json.type question.content.type
          json.label_text question.content.label_text

          if question.content.type == 'external_survey'
            begin
              json.sdk_configuration_values JSON.parse(question.content.sdk_configuration_values)
            rescue StandardError
              nil
            end
            json.extract! question.content, :url, :embedded_data_fields, :survey_provider
          elsif question.content.type == 'checkbox' || question.content.type == 'radio'
            json.options question.content.options
          end
        end
      end
    end
  end
end

json.region do
  json.id @region.region_identifier
  json.name @region.name
end
