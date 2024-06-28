module Admins::SurveyQuestionsHelper
  def partial_for_survey_question(question)
    case question.content&.type
    when 'checkbox'
      'admins/survey_questions/fields/checkbox'
    when 'label'
      'admins/survey_questions/fields/label'
    when 'radio'
      'admins/survey_questions/fields/radio'
    else
      'admins/survey_questions/fields/text'
    end
  end
end
