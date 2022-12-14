class CaseStepsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_case
  before_action :set_step, only: %i[append reorder destroy]
  before_action :set_case_step, only: %i[reorder destroy]

  respond_to :html, :turbo_stream

  def index
    @used_step_ids = @case.steps.order(:row_order).pluck(:id)
    @steps = @case.suite.project.steps
      .where('UPPER(title) LIKE ?', "%#{search_params[:title].to_s.upcase}%")

    @steps = @steps.where.not(id: @used_step_ids) if @used_step_ids.any?

    respond_with @steps
  end

  def add_new
    @step = @case.suite.project.steps.new(step_params)
    @case_step = @case.case_steps.new

    render :add_new
  end

  def builder
    respond_with @case
  end

  def create
    @step = @case.suite.project.steps.new(step_params)

    if @step.valid?
      @step.save

      @case_step = @case.case_steps.create(step: @step, row_order_position: :last)
      @steps = @case.steps.order(:row_order).load
    end

    respond_with @step, render: :create
  end

  def append
    @case_step = @case.steps << @step
    @steps = @case.steps.order(:row_order).load

    respond_with @step, render: :append
  end

  def reorder
    direction = reorder_params[:direction] == 'down' ? :down : :up

    @case_step.update(row_order_position: direction)
    @steps = @case.steps.order(:row_order).load

    respond_with @case_step, render: :reorder
  end

  def destroy
    @case_step.destroy

    respond_with @case_steps, render: :destroy, location: -> {
      project_suite_case_url @case.suite.project, @case.suite, @case
    }
  end

  private

  def reorder_params
    params.permit(:direction)
  end

  def search_params
    params.permit(:title)
  end

  def step_params
    params.require(:step).permit(:title, :description, :acceptance_criteria)
  end

  def set_case
    @case = Case
      .joins(suite: { project: :user })
      .find_by!('users.id = ? AND cases.id = ?', current_user.id, params[:case_id])
  end

  def set_step
    @step = Step
      .joins(project: :user)
      .find_by!('users.id = ? AND steps.id = ?', current_user.id, params[:id])
  end

  def set_case_step
    @case_step = @case.case_steps.find_by!(step_id: @step.id)
  end
end
