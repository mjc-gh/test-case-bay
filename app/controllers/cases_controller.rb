class CasesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project
  before_action :set_suite
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    @ordered_steps = @case.steps.order(row_order: :asc).load

    respond_with @case
  end

  def new
    @case = @suite.cases.new

    respond_with @case
  end

  def edit
    respond_with @case
  end

  def create
    @case = @suite.cases.create(case_params)

    respond_with @project, @suite, @case
  end

  def update
    @case.update(case_params)

    respond_with @project, @suite, @case
  end

  def destroy
    @case.destroy

    respond_with @case, location: -> { [@project, @suite] }
  end

  private

  def set_suite
    @suite = @project.suites.find(params[:suite_id])
  end

  def set_case
    @case = @suite.cases.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:title, :description, :acceptance_criteria)
  end
end
