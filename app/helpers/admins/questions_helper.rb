module Admins::QuestionsHelper
  def partial_for_question(question)
    case question.content&.type
    when 'checkbox'
      'admins/questions/fields/checkbox'
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
    when 'label'
      'admins/questions/field_previews/label'
    when 'radio'
      'admins/questions/field_previews/radio'
    else
      'admins/questions/field_previews/text'
    end
  end
end
