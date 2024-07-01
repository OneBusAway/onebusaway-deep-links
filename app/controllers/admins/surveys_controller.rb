class Admins::SurveysController < ApplicationController
  before_action :admin_required
  before_action :load_study

  def new
    @survey = @study.surveys.build
  end

  def create
    @survey = @study.surveys.new(survey_params)
    if @survey.save
      redirect_to admin_study_survey_path(@study, @survey), notice: 'Survey was created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @survey = @study.surveys.find(params[:id])
  end

  def edit
    @survey = @study.surveys.find(params[:id])
  end

  def update
    @survey = @study.surveys.find(params[:id])
    if @survey.update(survey_params)
      redirect_to admin_study_survey_path(@study, @survey), notice: 'Survey was updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @survey = @study.surveys.find(params[:id])
    @survey.destroy
    redirect_to admin_study_path(@study), notice: 'Survey was deleted.'
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :enabled, :extra_data, questions: [])
  end

  def load_study
    @study = current_admin_region.studies.find(params[:study_id])
  end
end
