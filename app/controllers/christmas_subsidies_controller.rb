class ChristmasSubsidiesController < ApplicationController
  before_action :set_christmas_subsidy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # # GET /christmas_subsidies
  # def index
  #   @christmas_subsidies = ChristmasSubsidy.all
  #   # @christmas_subsidy = ChristmasSubsidy.new
  # end

  # # GET /christmas_subsidies/1
  # def show
  # end

  # GET /christmas_subsidies/new
  def new
    @christmas_subsidy = ChristmasSubsidy.new
  end

  # GET /christmas_subsidies/1/edit
  def edit
  end

  # POST /christmas_subsidies
  def create
    @christmas_subsidy = ChristmasSubsidy.new(christmas_subsidy_params)

    if @christmas_subsidy.save
      redirect_to latest_christmas_subsidy_url, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /christmas_subsidies/1
  def update
    @christmas_subsidy = @christmas_subsidy.dup
    @christmas_subsidy.assign_attributes(christmas_subsidy_params)
    if @christmas_subsidy.save
      redirect_to latest_christmas_subsidy_url, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /christmas_subsidies/1
  def destroy
    @christmas_subsidy.destroy
    redirect_to latest_christmas_subsidy_url, notice: t('.success')
  end

  def latest
    @christmas_subsidy = ChristmasSubsidy.latest || ChristmasSubsidy.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_christmas_subsidy
      @christmas_subsidy = ChristmasSubsidy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def christmas_subsidy_params
      params.require(:christmas_subsidy).permit(:name, :abbr_name, :percentage, :status)
    end
end
