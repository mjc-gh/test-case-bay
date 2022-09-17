class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]

  respond_to :html

  # GET /projects
  def index
    @projects = current_user.projects.load

    respond_with @projects
  end

  # GET /projects/1
  def show
    respond_with @project
  end

  # GET /projects/new
  def new
    @project = current_user.projects.new

    respond_with @project
  end

  # GET /projects/1/edit
  def edit
    respond_with @project
  end

  # POST /projects
  def create
    @project = current_user.projects.create(project_params)

    respond_with @project
  end

  # PATCH/PUT /projects/1
  def update
    @project.update project_params

    respond_with @project
  end

  # DELETE /projects/1
  def destroy
    @project.destroy

    respond_with @project
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
