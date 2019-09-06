class EmployeePaygradesController < ApplicationController
  before_action :set_employee_paygrade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /employee_paygrades
  def index
    @employee_paygrades = EmployeePaygrade.get_latest
    @employee_paygrade = EmployeePaygrade.new
  end

  # GET /employee_paygrades/1
  def show
  end

  # GET /employee_paygrades/new
  def new
    @employee_paygrade = EmployeePaygrade.new
  end

  # GET /employee_paygrades/1/edit
  def edit
  end

  # POST /employee_paygrades
  def create
    @employee_paygrade = EmployeePaygrade.new(employee_paygrade_params)

    if @employee_paygrade.save
      redirect_to @employee_paygrade.goto_cancel_to_or(employee_url(@employee_paygrade.employee, active_tab: :tab_remuneration)), notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /employee_paygrades/1
  def update
    if @employee_paygrade.update(employee_paygrade_params)
      redirect_to @employee_paygrade.goto_cancel_to_or(employee_url(@employee_paygrade.employee, active_tab: :tab_remuneration)), notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /employee_paygrades/1
  def destroy
    @employee_paygrade.destroy
    redirect_to @employee_paygrade.goto_cancel_to_or(employee_url(@employee_paygrade.employee, active_tab: :tab_remuneration)), notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_paygrade
      @employee_paygrade = EmployeePaygrade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_paygrade_params
      params.require(:employee_paygrade).permit(:level, :paygrade, :since, :until, :employee_id, :paygrade_change_reason_id, :base_salary, :cancel_url, :redirect_url)
    end
end
