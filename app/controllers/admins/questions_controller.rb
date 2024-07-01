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
      render :new, status: :unprocessable_entity
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
      render :edit, status: :unprocessable_entity
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
    permitted_params_for_content_type(content_type)
  end

  def permitted_params_for_content_type(content_type)
    case content_type
    when 'label', 'text'
      params.require(:question).permit(:position, content_attributes: %i[type label_text])
    when 'checkbox', 'radio'
      params.require(:question).permit(:position, content_attributes: [:type, :label_text, { options: [] }])
    else
      raise "Unknown content type: #{content_type}"
    end
  end
end
