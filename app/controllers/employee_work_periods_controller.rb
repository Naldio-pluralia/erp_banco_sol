class EmployeeWorkPeriodsController < ApplicationController
  before_action :set_employee_work_period, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /employee_work_periods
  def index
    @employee_work_periods = EmployeeWorkPeriod.all
    @employee_work_period = EmployeeWorkPeriod.new
  end

  # GET /employee_work_periods/1
  def show
  end

  # GET /employee_work_periods/new
  def new
    @employee_work_period = EmployeeWorkPeriod.new
  end

  # GET /employee_work_periods/1/edit
  def edit
  end

  # POST /employee_work_periods
  def create
    @employee_work_period = EmployeeWorkPeriod.new(employee_work_period_params)

    if @employee_work_period.save
      redirect_to @employee_work_period.redirect_url || employee_url(@employee_work_period.employee, active_tab: :tab_remuneration), notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /employee_work_periods/1
  def update
    if @employee_work_period.update(employee_work_period_params)
      redirect_to @employee_work_period.redirect_url || employee_url(@employee_work_period.employee, active_tab: :tab_remuneration), notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /employee_work_periods/1
  def destroy
    @employee_work_period.destroy
    redirect_to @employee_work_period.redirect_url || employee_url(@employee_work_period.employee, active_tab: :tab_remuneration), notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_work_period
      @employee_work_period = EmployeeWorkPeriod.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_work_period_params
      params.require(:employee_work_period).permit(:since, :until, :employee_id, :cancel_url, :redirect_url)
    end
end
