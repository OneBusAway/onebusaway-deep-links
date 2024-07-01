class Admins::QuestionsController < ApplicationController
  before_action :admin_required
  before_action :load_survey

  def new
    @question = @survey.questions.build
    @question.content.type = params[:content]&.presence || 'text'
  end

  def create
    @question = @survey
                         .questions
                         .new(question_params)
    
    if @question.save
      redirect_to admin_study_survey_path(@survey.study, @survey), notice: 'Question was created.'
    else
      render :new
    end
  end

  def show
    @question = @survey.questions.find(params[:id])
  end

  def edit
    @question = @survey.questions.find(params[:id])
  end

  def update
    @question = @survey.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to admin_study_survey_path(@study, @survey), notice: 'Question was updated.'
    else
      render :edit
    end
  end

  def destroy
    @question = @survey.questions.find(params[:id])
    @question.destroy
    redirect_to admin_study_survey_path(@study, @survey), notice: 'Question was deleted.'
  end

  private

  def load_survey
    @survey = current_admin_region.surveys.find(params[:survey_id])
  end

  def question_params
    content_type = params.dig(:question, :content_attributes, :type)

    attrs_for_type = if content_type
                       base_attrs = %i[label_text type]

                       if content_type = 'checkbox' || 'radio'
                         base_attrs << {options: []}
                       end
                     else
                       nil
                     end

    params.require(:question).permit(
      :position,
      content_attributes: attrs_for_type
    )
  end
end
