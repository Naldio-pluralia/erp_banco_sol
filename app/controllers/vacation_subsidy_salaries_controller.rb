# class VacationSubsidySalariesController < ApplicationController
#   before_action :set_vacation_subsidy_salary, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_account!
#   load_and_authorize_resource

#   # GET /vacation_subsidy_salaries
#   def index
#     @vacation_subsidy_salaries = VacationSubsidySalary.all
#     # @vacation_subsidy_salary = VacationSubsidySalary.new
#   end

#   # GET /vacation_subsidy_salaries/1
#   def show
#   end

#   # GET /vacation_subsidy_salaries/new
#   def new
#     @vacation_subsidy_salary = VacationSubsidySalary.new
#   end

#   # GET /vacation_subsidy_salaries/1/edit
#   def edit
#   end

#   # POST /vacation_subsidy_salaries
#   def create
#     @vacation_subsidy_salary = VacationSubsidySalary.new(vacation_subsidy_salary_params)

#     if @vacation_subsidy_salary.save
#       redirect_to @vacation_subsidy_salary, notice: t('.success')
#     else
#       render :new
#     end
#   end

#   # PATCH/PUT /vacation_subsidy_salaries/1
#   def update
#     if @vacation_subsidy_salary.update(vacation_subsidy_salary_params)
#       redirect_to @vacation_subsidy_salary, notice: t('.success')
#     else
#       render :edit
#     end
#   end

#   # DELETE /vacation_subsidy_salaries/1
#   def destroy
#     @vacation_subsidy_salary.destroy
#     redirect_to vacation_subsidy_salaries_url, notice: t('.success')
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_vacation_subsidy_salary
#       @vacation_subsidy_salary = VacationSubsidySalary.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def vacation_subsidy_salary_params
#       params.require(:vacation_subsidy_salary).permit(:name, :abbr_name, :value, :percentage, :year, :salary_id, :vacation_subsidy_id)
#     end
# end
