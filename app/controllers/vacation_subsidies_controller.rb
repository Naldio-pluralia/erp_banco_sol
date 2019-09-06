class VacationSubsidiesController < ApplicationController
  before_action :set_vacation_subsidy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /vacation_subsidies
  def index
    @vacation_subsidies = VacationSubsidy.all
    # @vacation_subsidy = VacationSubsidy.new
  end

  # GET /vacation_subsidies/1
  def show
  end

  # GET /vacation_subsidies/new
  def new
    @vacation_subsidy = VacationSubsidy.new
  end

  # GET /vacation_subsidies/1/edit
  def edit
  end

  # POST /vacation_subsidies
  def create
    @vacation_subsidy = VacationSubsidy.new(vacation_subsidy_params)

    if @vacation_subsidy.save
      redirect_to latest_vacation_subsidy_url, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /vacation_subsidies/1
  def update
    @vacation_subsidy = @vacation_subsidy.dup
    @vacation_subsidy.assign_attributes(vacation_subsidy_params)
    if @vacation_subsidy.save
      redirect_to latest_vacation_subsidy_url, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /vacation_subsidies/1
  def destroy
    @vacation_subsidy.destroy
    redirect_to latest_vacation_subsidy_url, notice: t('.success')
  end

  def latest
    @vacation_subsidy = VacationSubsidy.latest || VacationSubsidy.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation_subsidy
      @vacation_subsidy = VacationSubsidy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vacation_subsidy_params
      params.require(:vacation_subsidy).permit(:name, :abbr_name, :percentage, :status)
    end
end
