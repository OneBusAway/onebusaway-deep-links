json.survey_response do
  json.id @survey_response.to_param
  json.user_identifier @survey_response.user_identifier
  json.update_path api_v1_survey_response_path(@survey_response)
end