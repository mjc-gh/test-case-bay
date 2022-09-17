class StepsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project
  before_action :set_step, only: [:destroy]

  respond_to :html

  def create
    @step = @project.steps.create(step_params)

    respond_with @step, location: -> { @project }
  end

  def destroy
    @step.destroy

    respond_with @step, location: -> { @project }
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:title, :description, :acceptance_criteria)
  end
end
