class EmployeeSalaryFamiliesController < ApplicationController
  before_action :set_employee_salary_family, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_salary_families
  def index
    @employee_salary_families = EmployeeSalaryFamily.all
    @employee_salary_family = EmployeeSalaryFamily.new
    @employee_salary_family.cancel_and_redirect_url_to(employee_salary_families_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_salary_families.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_salary_families/1
  def show
    @employee_salary_family.cancel_and_redirect_url_to(employee_salary_family_url(@employee_salary_family))
    respond_to do |f|
      f.html
      f.json { render json: @employee_salary_family.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_salary_families/new
  def new
    @employee_salary_family = EmployeeSalaryFamily.new
    @employee_salary_family.cancel_url = employee_salary_families_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_salary_family.as_json}
      f.js
    end
  end

  # GET /employee_salary_families/1/edit
  def edit
    @employee_salary_family.cancel_and_redirect_url_to(employee_salary_family_url(@employee_salary_family))
    respond_to do |f|
      f.html
      f.json { render json: @employee_salary_family.as_json}
      f.js
    end
  end

  # POST /employee_salary_families
  def create
    @employee_salary_family = EmployeeSalaryFamily.new(employee_salary_family_params)
    respond_to do |f|
      if @employee_salary_family.save
        f.html { redirect_to @employee_salary_family.redirect_url || redirect_url || employee_salary_family_url(@employee_salary_family), notice: controller_t('.saved') }
        f.json { render json: @employee_salary_family.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_salary_family.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_salary_families/1
  def update
    respond_to do |f|
      if @employee_salary_family.update(employee_salary_family_params)
        f.html { redirect_to @employee_salary_family.redirect_url || redirect_url || employee_salary_family_url(@employee_salary_family), notice: controller_t('.updated') }
        f.json { render json: @employee_salary_family.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_salary_family.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_salary_families/1
  def destroy
    @employee_salary_family.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_salary_families_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_salary_family
      @employee_salary_family = EmployeeSalaryFamily.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_salary_family_params
      params.require(:employee_salary_family).permit(:employee_id, :salary_family_id, :paygrade_change_reason_id, :level, :paygrade, :since, :base_salary, :cancel_url, :redirect_url)
    end
end
