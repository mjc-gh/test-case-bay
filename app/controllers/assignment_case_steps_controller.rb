class AssignmentCaseStepsController < ApplicationController
  before_action :set_assignment
  before_action :set_case
  before_action :set_step, only: %i[edit update]

  respond_to :html, :turbo_stream

  def index
    @steps = @case.steps.order(:row_order).load
    @assignment_case_steps = @assignment.assignment_case_steps.group_by(&:step_id)
    @assignment_case_steps.transform_values! { |v| v.shift }

    render :index
  end

  def edit
    @assignment_case_step = AssignmentCaseStep.new

    respond_with @step
  end

  def update
    @assignment_case_step = @assignment.assignment_case_steps.new(case: @case, step: @step)
    @assignment_case_step.passed = assignment_case_step_params[:status] == 'passed'
    @assignment_case_step.attributes = assignment_case_step_failure_params unless @assignment_case_step.passed?
    @assignment_case_step.save

    respond_with @assignment_case_step, render: :update
  end

  private

  def assignment_case_step_params
    params.permit(:status)
  end

  def assignment_case_step_failure_params
    params.require(:assignment_case_step).permit(:notes)
  end

  def set_assignment
    @assignment = Assignment.includes(run: %i[cases project])
      .find_by!(token: params[:assignment_id])
  end

  def set_case
    @case = @assignment.run.project.cases.find_by!(id: params[:case_id])
  end

  def set_step
    @step = @case.steps.find_by!(id: params[:id])
  end
end
