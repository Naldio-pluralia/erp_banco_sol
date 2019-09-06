# class ChristmasSubsidySalariesController < ApplicationController
#   before_action :set_christmas_subsidy_salary, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_account!
#   load_and_authorize_resource

#   # GET /christmas_subsidy_salaries
#   def index
#     @christmas_subsidy_salaries = ChristmasSubsidySalary.all
#     # @christmas_subsidy_salary = ChristmasSubsidySalary.new
#   end

#   # GET /christmas_subsidy_salaries/1
#   def show
#   end

#   # GET /christmas_subsidy_salaries/new
#   def new
#     @christmas_subsidy_salary = ChristmasSubsidySalary.new
#   end

#   # GET /christmas_subsidy_salaries/1/edit
#   def edit
#   end

#   # POST /christmas_subsidy_salaries
#   def create
#     @christmas_subsidy_salary = ChristmasSubsidySalary.new(christmas_subsidy_salary_params)

#     if @christmas_subsidy_salary.save
#       redirect_to @christmas_subsidy_salary, notice: t('.success')
#     else
#       render :new
#     end
#   end

#   # PATCH/PUT /christmas_subsidy_salaries/1
#   def update
#     if @christmas_subsidy_salary.update(christmas_subsidy_salary_params)
#       redirect_to @christmas_subsidy_salary, notice: t('.success')
#     else
#       render :edit
#     end
#   end

#   # DELETE /christmas_subsidy_salaries/1
#   def destroy
#     @christmas_subsidy_salary.destroy
#     redirect_to christmas_subsidy_salaries_url, notice: t('.success')
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_christmas_subsidy_salary
#       @christmas_subsidy_salary = ChristmasSubsidySalary.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def christmas_subsidy_salary_params
#       params.require(:christmas_subsidy_salary).permit(:name, :abbr_name, :value, :year, :salary_id, :christmas_subsidy_id)
#     end
# end
