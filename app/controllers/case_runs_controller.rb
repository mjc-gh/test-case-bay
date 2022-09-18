class CaseRunsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_run
  before_action :set_case, only: %i[append reorder destroy]
  before_action :set_case_run, only: %i[reorder destroy]

  respond_to :html, :turbo_stream

  def index
    @used_case_ids = @run.cases.order(:row_order).pluck(:id)
    @cases = @run.project.cases
      .where('UPPER(cases.title) LIKE ?', "%#{search_params[:title].to_s.upcase}%")

    @cases = @cases.where.not(id: @used_case_ids) if @used_case_ids.any?

    respond_with @cases
  end

  def append
    @run_case = @run.cases << @case

    respond_with @case, render: :append
  end

  def reorder
    direction = reorder_params[:direction] == 'down' ? :down : :up

    @case_run.update(row_order_position: direction)
    @cases = @run.cases.order(:row_order).load

    respond_with @case_step, render: :reorder
  end

  def destroy
    @case_run.destroy

    respond_with @case_run, render: :destroy, location: -> {
      runs_url @run
    }
  end

  private

  def search_params
    params.permit(:title)
  end

  def reorder_params
    params.permit(:direction)
  end

  def set_run
    @run = Run.joins(:project)
      .where('projects.user_id = ?', current_user.id)
      .find_by!(id: params[:run_id])
  end

  def set_case
    @case = @run.project.cases.find_by!(id: params[:id])
  end

  def set_case_run
    @case_run = @case.case_runs.find_by!(run_id: @run.id)
  end
end
