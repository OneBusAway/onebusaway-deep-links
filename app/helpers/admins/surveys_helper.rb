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
    return "Not visible" unless survey.show_on_map || survey.show_on_stops

    if survey.show_on_map
      handle_map_visibility(survey)
    elsif survey.show_on_stops
      handle_stop_visibility(survey)
    end
  end

  private

  def handle_map_visibility(survey)
    if survey.show_on_stops
      return "Visible on specific stops, routes and map" if survey.visible_stop_list.present? && survey.visible_route_list.present?
      return "Visible on specific stops and map" if survey.visible_stop_list.present?
      return "Visible on specific routes and map" if survey.visible_route_list.present?

      "Visible on all stops and map"
    else
      "Visible on map"
    end
  end

  def handle_stop_visibility(survey)
    if survey.visible_stop_list.present?
      return "Visible on specific stops and routes" if survey.visible_route_list.present?

      "Visible on specific stops"
    elsif survey.visible_route_list.present?
      "Visible on specific routes"
    else
      "Visible on all stops"
    end
  end
end
