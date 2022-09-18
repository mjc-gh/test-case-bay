class AssignmentsController < ApplicationController
  before_action :authenticate_user!, except: :show

  before_action :set_run, except: :show

  # Public URL using token
  # TODO make a separate controller?
  def show
    @assignment = Assignment.includes(run: :cases)
      .find_by(token: params[:id])

    @run = @assignment.run
    @cases = @assignment.run.cases

    respond_with @assignment
  end

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
