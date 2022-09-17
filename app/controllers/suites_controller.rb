class SuitesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project
  before_action :set_suite, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    @cases = @suite.cases.order('title').load

    respond_with @suite
  end

  def new
    @suite = @project.suites.new

    respond_with @suite
  end

  def edit
    respond_with @suite
  end

  def create
    @suite = @project.suites.create(suite_params)

    respond_with @project, @suite
  end

  def update
    @suite.update(suite_params)

    respond_with @project, @suite
  end

  def destroy
    @suite.destroy

    respond_with @suite, location: -> { @project }
  end

  private

  def set_suite
    @suite = @project.suites.find(params[:id])
  end

  def suite_params
    params.require(:suite).permit(:title, :description)
  end
end
