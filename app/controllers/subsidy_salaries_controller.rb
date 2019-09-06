class SubsidySalariesController < ApplicationController
  before_action :set_subsidy_salary, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /subsidy_salaries
  def index
    @subsidy_salaries = SubsidySalary.all
    @subsidy_salary = SubsidySalary.new
  end

  # GET /subsidy_salaries/1
  def show
  end

  # GET /subsidy_salaries/new
  def new
    @subsidy_salary = SubsidySalary.new
  end

  # GET /subsidy_salaries/1/edit
  def edit
  end

  # POST /subsidy_salaries
  def create
    @subsidy_salary = SubsidySalary.new(subsidy_salary_params)

    if @subsidy_salary.save
      redirect_to @subsidy_salary, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /subsidy_salaries/1
  def update
    if @subsidy_salary.update(subsidy_salary_params)
      redirect_to @subsidy_salary, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /subsidy_salaries/1
  def destroy
    @subsidy_salary.destroy
    redirect_to subsidy_salaries_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsidy_salary
      @subsidy_salary = SubsidySalary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subsidy_salary_params
      params.require(:subsidy_salary).permit(:value, :salary_id, :subsidy_type)
    end
end
