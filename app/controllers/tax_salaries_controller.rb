class TaxSalariesController < ApplicationController
  before_action :set_tax_salary, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /tax_salaries
  def index
    @tax_salaries = TaxSalary.all
    @tax_salary = TaxSalary.new
  end

  # GET /tax_salaries/1
  def show
  end

  # GET /tax_salaries/new
  def new
    @tax_salary = TaxSalary.new
  end

  # GET /tax_salaries/1/edit
  def edit
  end

  # POST /tax_salaries
  def create
    @tax_salary = TaxSalary.new(tax_salary_params)

    if @tax_salary.save
      redirect_to @tax_salary, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /tax_salaries/1
  def update
    if @tax_salary.update(tax_salary_params)
      redirect_to @tax_salary, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /tax_salaries/1
  def destroy
    @tax_salary.destroy
    redirect_to tax_salaries_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_salary
      @tax_salary = TaxSalary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_salary_params
      params.require(:tax_salary).permit(:value, :salary_id, :tax_type_id)
    end
end
