# class WageIncomeTaxSalariesController < ApplicationController
#   before_action :set_wage_income_tax_salary, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_account!
#   load_and_authorize_resource

#   # GET /wage_income_tax_salaries
#   def index
#     @wage_income_tax_salaries = WageIncomeTaxSalary.all
#     # @wage_income_tax_salary = WageIncomeTaxSalary.new
#   end

#   # GET /wage_income_tax_salaries/1
#   def show
#   end

#   # GET /wage_income_tax_salaries/new
#   def new
#     @wage_income_tax_salary = WageIncomeTaxSalary.new
#   end

#   # GET /wage_income_tax_salaries/1/edit
#   def edit
#   end

#   # POST /wage_income_tax_salaries
#   def create
#     @wage_income_tax_salary = WageIncomeTaxSalary.new(wage_income_tax_salary_params)

#     if @wage_income_tax_salary.save
#       redirect_to @wage_income_tax_salary, notice: t('.success')
#     else
#       render :new
#     end
#   end

#   # PATCH/PUT /wage_income_tax_salaries/1
#   def update
#     if @wage_income_tax_salary.update(wage_income_tax_salary_params)
#       redirect_to @wage_income_tax_salary, notice: t('.success')
#     else
#       render :edit
#     end
#   end

#   # DELETE /wage_income_tax_salaries/1
#   def destroy
#     @wage_income_tax_salary.destroy
#     redirect_to wage_income_tax_salaries_url, notice: t('.success')
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_wage_income_tax_salary
#       @wage_income_tax_salary = WageIncomeTaxSalary.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def wage_income_tax_salary_params
#       params.require(:wage_income_tax_salary).permit(:name, :abbr_name, :value, :salary_id, :wage_income_tax_id)
#     end
# end
