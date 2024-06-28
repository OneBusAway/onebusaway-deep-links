class Admins::SurveyQuestionsController < ApplicationController
  before_action :admin_required
  before_action :load_study_invite

  def new
    @survey_question = @study_invite.survey_questions.build
    @survey_question.content.type = params[:content]&.presence || 'text'
  end

  def create
    @survey_question = @study_invite
                         .survey_questions
                         .new(survey_question_params)
    
    if @survey_question.save
      redirect_to admin_study_study_invite_path(@study_invite.study, @study_invite), notice: 'Survey question was created.'
    else
      render :new
    end
  end

  def show
    @survey_question = @study_invite.survey_questions.find(params[:id])
  end

  def edit
    @survey_question = @study_invite.survey_questions.find(params[:id])
  end

  def update
    @survey_question = @study_invite.survey_questions.find(params[:id])
    if @survey_question.update(survey_question_params)
      redirect_to admin_study_study_invite_path(@study, @study_invite), notice: 'Survey question was updated.'
    else
      render :edit
    end
  end

  def destroy
    @survey_question = @study_invite.survey_questions.find(params[:id])
    @survey_question.destroy
    redirect_to admin_study_study_invite_path(@study, @study_invite), notice: 'Survey question was deleted.'
  end

  private

  def load_study_invite
    @study_invite = current_admin_region.study_invites.find(params[:study_invite_id])
  end

  def survey_question_params
    content_type = params.dig(:survey_question, :content_attributes, :type)

    attrs_for_type = if content_type
                       base_attrs = %i[label_text type]

                       if content_type = 'checkbox' || 'radio'
                         base_attrs << {options: []}
                       end
                     else
                       nil
                     end

    params.require(:survey_question).permit(
      :position,
      content_attributes: attrs_for_type
    )
  end
end
