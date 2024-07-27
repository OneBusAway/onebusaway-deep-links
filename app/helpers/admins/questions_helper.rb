module Admins::QuestionsHelper
  def partial_for_question(question)
    case question.content&.type
    when 'checkbox'
      'admins/questions/fields/checkbox'
    when 'external_survey'
      'admins/questions/fields/external_survey'
    when 'label'
      'admins/questions/fields/label'
    when 'radio'
      'admins/questions/fields/radio'
    else
      'admins/questions/fields/text'
    end
  end

  def partial_for_field_preview(question)
    case question.content&.type
    when 'checkbox'
      'admins/questions/field_previews/checkbox'
    when 'external_survey'
      'admins/questions/field_previews/external_survey'
    when 'label'
      'admins/questions/field_previews/label'
    when 'radio'
      'admins/questions/field_previews/radio'
    else
      'admins/questions/field_previews/text'
    end
  end

  def question_form_post_url(question)
    if question.persisted?
      admin_study_survey_question_path(question.survey.study, question.survey, question)
    else
      admin_study_survey_questions_path(question.survey.study, question.survey)
    end
  end
end
