module Admins::SurveysHelper
  def survey_provider_options
    [
      ["Google Forms", "google_forms"],
      ["Qualtrics", "qualtrics"],
      ["SurveyMonkey", "survey_monkey"]
    ]
  end

  # Return a string describing visibility of the survey
  # @param survey [Survey]
  # @return [String] the visibility of the survey
  def survey_visibility(survey)
    if survey.show_on_map && survey.show_on_stops
      return "Visible on specific stops and routes" if survey.visible_stop_list.present? && survey.visible_route_list.present?
      return "Visible on specific stops and map" if survey.visible_stop_list.present?
      return "Visible on specific routes and map" if survey.visible_route_list.present?

      "Visible on all stops and map"
    elsif survey.show_on_stops
      "Visible on all stops"
    elsif survey.show_on_map
      "Visible on map"
    else
      "Not visible"
    end
  end
end
