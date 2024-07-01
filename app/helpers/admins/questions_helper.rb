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
end
