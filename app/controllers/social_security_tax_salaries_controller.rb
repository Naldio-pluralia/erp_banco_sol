# class SocialSecurityTaxSalariesController < ApplicationController
#   before_action :set_social_security_tax_salary, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_account!
#   load_and_authorize_resource

#   # GET /social_security_tax_salaries
#   def index
#     @social_security_tax_salaries = SocialSecurityTaxSalary.all
#     # @social_security_tax_salary = SocialSecurityTaxSalary.new
#   end

#   # GET /social_security_tax_salaries/1
#   def show
#   end

#   # GET /social_security_tax_salaries/new
#   def new
#     @social_security_tax_salary = SocialSecurityTaxSalary.new
#   end

#   # GET /social_security_tax_salaries/1/edit
#   def edit
#   end

#   # POST /social_security_tax_salaries
#   def create
#     @social_security_tax_salary = SocialSecurityTaxSalary.new(social_security_tax_salary_params)

#     if @social_security_tax_salary.save
#       redirect_to @social_security_tax_salary, notice: t('.success')
#     else
#       render :new
#     end
#   end

#   # PATCH/PUT /social_security_tax_salaries/1
#   def update
#     if @social_security_tax_salary.update(social_security_tax_salary_params)
#       redirect_to @social_security_tax_salary, notice: t('.success')
#     else
#       render :edit
#     end
#   end

#   # DELETE /social_security_tax_salaries/1
#   def destroy
#     @social_security_tax_salary.destroy
#     redirect_to social_security_tax_salaries_url, notice: t('.success')
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_social_security_tax_salary
#       @social_security_tax_salary = SocialSecurityTaxSalary.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def social_security_tax_salary_params
#       params.require(:social_security_tax_salary).permit(:name, :abbr_name, :value, :salary_id, :social_security_tax_id)
#     end
# end
