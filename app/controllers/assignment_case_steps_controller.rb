class AssignmentCaseStepsController < ApplicationController
  before_action :set_assignment
  before_action :set_case, only: :index

  def index
    @steps = @case.steps.order(:row_order).load

    render :index
  end

  def update
  end

  private

  def set_assignment
    @assignment = Assignment.includes(run: %i[cases project])
      .find_by!(token: params[:assignment_id])
  end

  def set_case
    @case = @assignment.run.project.cases.find_by!(id: params[:case_id])
  end
end
