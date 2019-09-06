class SalariesController < ApplicationController
  before_action :set_salary, only: [:show, :edit, :update, :destroy, :partial_view_salary, :add_subsidy, :add_tax, :remove_subsidy, :remove_tax, :activate, :pay]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout "partial_view_application", only: [:partial_view_salary]

  # GET /salaries
  def index
    params[:map_type] ||= 'annual'
    params[:year] ||= DateTime.now.year
    params[:period] ||= "#{DateTime.now.month}/#{DateTime.now.year}"
    if params[:map_type] == 'monthly'
      params[:since] = params[:until] = params[:year]= nil
    elsif params[:map_type] == 'all'
      params[:year] = params[:period]# = nil
    elsif params[:map_type] == 'annual'
      params[:until] = params[:since] = params[:period]# = nil
    end

    @salaries = Salary.includes(:employee_salary_family)
      .period(params[:period])
      .since(params[:since])
      .until(params[:until])
      .year(params[:year])
      .employee_id(params[:employee_id])
      .status(params[:status])
    @salary = Salary.new
  end

  # GET /salaries/1
  def show
  end

  # GET /salaries/new
  def new
    @salary = Salary.new
  end

  # GET /salaries/1/edit
  def edit
  end

  # POST /salaries
  def create
    @salary = Salary.new(salary_params)

    if @salary.save
      redirect_to @salary, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /salaries/1
  def update
    if @salary.update(salary_params)
      redirect_to @salary, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /salaries/1
  def destroy
    @salary.destroy
    redirect_to salaries_url, notice: t('.success')
  end

  def new_salary_map
    @employee_salary_families = EmployeeSalaryFamily.includes(:employee).latest
    @salaries = @employee_salary_families.map{|e| Salary.new(employee_salary_family_id: e.id) }
  end

  def create_salary_map
    @salaries = Salary.create(salaries_params)
    period = @salaries&.last&.period || "#{DateTime.now.month}/#{DateTime.now.year}"
    redirect_to salaries_url(period: "#{period.month}/#{period.year}"), notice: controller_t(".success")
  end

  def activate
    respond_to do |format|
      if @salary.active!
        format.html
        format.js { render :show}
      else
        format.html
        format.js { render :show }
      end
    end
  end

  def pay
    respond_to do |format|
      if @salary.paid!
        format.html
        format.js { render :show}
      else
        format.html
        format.js { render :show }
      end
    end
  end



  def add_subsidy
    subsidy_type = SubsidyType.find(params[:subsidy_type_id])
    new_subsidy = @salary.new_subsidy(subsidy_type)
    respond_to do |format|
      if new_subsidy.save
        format.html
        format.js { render :show}
      else
        format.html
        format.js { render :show }
      end
    end
  end

  def add_tax
    tax_type = TaxType.find(params[:tax_type_id])
    new_tax = @salary.new_tax(tax_type)
    respond_to do |format|
      if new_tax.save
        format.html
        format.js { render :show}
      else
        p new_tax.errors.messages
        p new_tax
        format.html
        format.js { render :show }
      end
    end
  end

  def remove_subsidy
    @subsidy_salary = @salary.subsidy_salaries.find(params[:subsidy_salary_id])
    @subsidy_salary.destroy
    respond_to do |format|
      format.html
      format.js { render :show}
    end
  end

  def remove_tax
    @tax_salary = @salary.tax_salaries.find(params[:tax_salary_id])
    @tax_salary.destroy
    respond_to do |format|
      format.html
      format.js { render :show}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary
      @salary = Salary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_params
      params.require(:salary).permit(:period, :employee_salary_family_id)
    end

    # Only allow a trusted parameter "white list" through.
    def salaries_params
      params.require(:salary).map {|m| m.permit(:employee_salary_family_id, :period) }
    end
end
