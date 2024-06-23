class Admins::StudiesController < ApplicationController
  before_action :admin_required

  def index
    @studies = current_admin_region.studies.order(:created_at)
  end

  def show
    @study = current_admin_region.studies.find(params[:id])
  end

  def new
    @study = current_admin_region.studies.build
  end

  def create
    @study = current_admin_region.studies.build(permitted_params)
    if @study.save
      redirect_to admin_studies_path, notice: 'Study created'
    else
      render :new
    end
  end

  def edit
    @study = current_admin_region.studies.find(params[:id])
  end

  def update
    @study = current_admin_region.studies.find(params[:id])
    if @study.update(permitted_params)
      redirect_to admin_studies_path, notice: 'Study updated'
    else
      render :edit
    end
  end

  def destroy
    @study = current_admin_region.studies.find(params[:id])
    @study.destroy
    redirect_to admin_studies_path, notice: 'Study deleted'
  end

  private def permitted_params
    params.require(:study).permit(:name, :description)
  end
end
