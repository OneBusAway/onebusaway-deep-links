module Admins::SurveysHelper
  def survey_provider_options
    [
      ["Google Forms", "google_forms"],
      ["Qualtrics", "qualtrics"],
      ["SurveyMonkey", "survey_monkey"]
    ]
  end
end
