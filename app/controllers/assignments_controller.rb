class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_run

  def new
    @assignment = @run.assignments.new

    respond_with @assignment
  end

  def create
    @assignment = @run.assignments.create(assignment_params)

    respond_with @assignment, location: -> {
      run_url(@run)
    }
  end

  private

  def assignment_params
    params.require(:assignment).permit(:email)
  end
end
