class TaxTypesController < ApplicationController
  before_action :set_tax_type, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /tax_types
  def index
    @tax_types = TaxType.get_by_code
    @tax_type = TaxType.new
  end

  # GET /tax_types/1
  def show
  end

  # GET /tax_types/new
  def new
    if params[:kind].blank?
      @tax_type = TaxType.new
    else
      @tax_type = TaxType.new(kind: params[:kind])
    end
    @tax_type.wage_income_tax_items.build([{},{},{},{},{}]) if @tax_type.wage_income?
  end

  # GET /tax_types/1/edit
  def edit
  end

  # POST /tax_types
  def create
    @tax_type = TaxType.new(tax_type_params)

    if @tax_type.save
      redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
    else
      p @tax_type.errors.messages
      render :new
    end
  end

  # PATCH/PUT /tax_types/1
  def update
    if @tax_type.dup_and_update(tax_type_params)
      redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /tax_types/1
  def destroy
    @tax_type.destroy
    redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
  end

  def partial_view_tax_types
    @tax_types = TaxType.get_by_code
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_type
      @tax_type = TaxType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_type_params
      params.require(:tax_type).permit(:code, :name, :abbr_name, :code, :value_mode,
        :value, :for_all, :status, :kind, :name, :abbr_name,
        :exempt_up_to, :max_wage, :max_wage_fixed_portion,
        :percentage_over_max_wage_excess, :max_wage_excess_of,
        :status, :percentage_from_employee, :percentage_from_employer, :cancel_url, :redirect_url,
        {wage_income_tax_items_attributes: [:from, :to, :fixed_portion, :percentage_over_the_excess, :excess_of], position_ids: [], function_ids: [], employee_ids: []})
    end
end
