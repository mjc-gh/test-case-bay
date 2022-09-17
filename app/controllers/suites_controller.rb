class SuitesController < ApplicationController
  before_action :set_suite, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @suites = @projects

    respond_with(@suites)
  end

  def show
    respond_with(@suite)
  end

  def new
    @suite = Suite.new
    respond_with(@suite)
  end

  def edit
  end

  def create
    @suite = Suite.new(suite_params)
    @suite.save
    respond_with(@suite)
  end

  def update
    @suite.update(suite_params)
    respond_with(@suite)
  end

  def destroy
    @suite.destroy
    respond_with(@suite)
  end

  private
    def set_suite
      @suite = Suite.find(params[:id])
    end

    def suite_params
      params.require(:suite).permit(:title, :description)
    end
end
