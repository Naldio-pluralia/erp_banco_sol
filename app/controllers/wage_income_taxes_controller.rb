class WageIncomeTaxesController < ApplicationController
  before_action :set_wage_income_tax, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # # GET /wage_income_taxes
  # def index
  #   @wage_income_taxes = WageIncomeTax.all
  #   # @wage_income_tax = WageIncomeTax.new
  # end

  # # GET /wage_income_taxes/1
  # def show
  # end

  # GET /wage_income_taxes/new
  def new
    @wage_income_tax = WageIncomeTax.new
  end

  # GET /wage_income_taxes/1/edit
  def edit
  end

  # POST /wage_income_taxes
  def create
    @wage_income_tax = WageIncomeTax.new(wage_income_tax_params)

    if @wage_income_tax.validate_and_save
      redirect_to latest_wage_income_tax_url, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /wage_income_taxes/1
  def update
    @wage_income_tax = @wage_income_tax.dup
    @wage_income_tax.assign_attributes(wage_income_tax_params)
    if @wage_income_tax.validate_and_save
      redirect_to latest_wage_income_tax_url, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /wage_income_taxes/1
  def destroy
    @wage_income_tax.destroy
    redirect_to latest_wage_income_tax_url, notice: t('.success')
  end

  def latest
    @wage_income_tax = WageIncomeTax.latest || WageIncomeTax.new
    if @wage_income_tax.new_record? || @wage_income_tax.wage_income_tax_items.empty?
      @wage_income_tax.wage_income_tax_items.build([{},{},{},{},{}])
    else

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wage_income_tax
      @wage_income_tax = WageIncomeTax.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wage_income_tax_params
      params.require(:wage_income_tax).permit(:name, :abbr_name, :exempt_up_to, :max_wage, :max_wage_fixed_portion, :percentage_over_max_wage_excess, :max_wage_excess_of, :status, wage_income_tax_items_attributes: [:from, :to, :fixed_portion, :percentage_over_the_excess, :excess_of])
    end
end
