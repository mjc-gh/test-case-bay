require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  around_action :set_timezone, if: :user_signed_in?

  private

  def not_found
    render :not_found, status: :not_found
  end

  def set_timezone
    tz = cookies.fetch('TZ') { 'UTC' }

    Time.use_zone tz do
      yield
    end
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_run
    @run = Run.joins(:project)
      .where('projects.user_id = ?', current_user.id)
      .find_by!(id: params[:run_id])
  end
end
