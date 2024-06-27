class Admins::StudyInvitesController < ApplicationController
  before_action :admin_required
  before_action :load_study

  def new
    @study_invite = @study.study_invites.build
  end

  def create
    @study_invite = @study.study_invites.new(study_invite_params)
    if @study_invite.save
      redirect_to admin_study_study_invite_path(@study, @study_invite), notice: 'Study invite was created.'
    else
      render :new
    end
  end

  def edit
    @study_invite = @study.study_invites.find(params[:id])
  end

  def update
    @study_invite = @study.study_invites.find(params[:id])
    if @study_invite.update(study_invite_params)
      redirect_to admin_study_study_invite_path(@study, @study_invite), notice: 'Study invite was updated.'
    else
      render :edit
    end
  end

  def destroy
    @study_invite = @study.study_invites.find(params[:id])
    @study_invite.destroy
    redirect_to admin_study_path(@study), notice: 'Study invite was deleted.'
  end

  private def study_invite_params
    params.require(:study_invite).permit(:name, :enabled, :extra_data, survey_questions: [])
  end

  private def load_study
    @study = current_admin_region.studies.find(params[:study_id])
  end
end
