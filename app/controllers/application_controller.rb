require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render :not_found, status: :not_found
  end
end
