class CaseStepsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_case
  before_action :set_step, only: %i[edit update]

  private

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
end
