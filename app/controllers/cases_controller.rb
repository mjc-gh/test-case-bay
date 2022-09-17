class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cases = Case.all
    respond_with(@cases)
  end

  def show
    respond_with(@case)
  end

  def new
    @case = Case.new
    respond_with(@case)
  end

  def edit
  end

  def create
    @case = Case.new(case_params)
    @case.save
    respond_with(@case)
  end

  def update
    @case.update(case_params)
    respond_with(@case)
  end

  def destroy
    @case.destroy
    respond_with(@case)
  end

  private
    def set_case
      @case = Case.find(params[:id])
    end

    def case_params
      params.require(:case).permit(:title, :details, :acceptance_criteria)
    end
end
