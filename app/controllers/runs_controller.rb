class RunsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_projects, only: %i[new create]
  before_action :set_run, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @runs = Run.joins(:project)
      .where('projects.user_id = ?', current_user.id)
      .load

    respond_with(@runs)
  end

  def show
    @ordered_cases = @run.cases.order(:row_order).load
    @assignments = @run.assignments.order(:created_at).load

    respond_with @run
  end

  def new
    @run = Run.new

    respond_with(@run)
  end

  def edit
    respond_with @run
  end

  def create
    @project = current_user.projects.find_by!(id: run_params[:project_id])
    @run = @project.runs.create(run_params.to_h.without(:project_id))

    respond_with @run
  rescue ActiveRecord::RecordNotFound => e
    @run = Run.new
    @run.errors.add :project_id, :invalid

    respond_with @run
  end

  def update
    @run.update(run_params)
    respond_with(@run)
  end

  def destroy
    @run.destroy

    respond_with(@run)
  end

  private

  def set_run
    @run = Run.joins(:project)
      .where('projects.user_id = ?', current_user.id)
      .find_by(id: params[:id])
  end

  def set_projects
    @projects = current_user.projects.load
  end

  def run_params
    params.require(:run).permit(:project_id, :title, :description)
  end
end
