class SubsidyTypesController < ApplicationController
  before_action :set_subsidy_type, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /subsidy_types
  def index
    @subsidy_types = SubsidyType.get_by_code
    @subsidy_type = SubsidyType.new
  end

  # GET /subsidy_types/1
  def show
  end

  # GET /subsidy_types/new
  def new
    if params[:kind].blank?
      @subsidy_type = SubsidyType.new
    else
      @subsidy_type = SubsidyType.new(kind: params[:kind])
    end
  end

  # GET /subsidy_types/1/edit
  def edit
  end

  # POST /subsidy_types
  def create
    @subsidy_type = SubsidyType.new(subsidy_type_params)

    if @subsidy_type.save
      redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /subsidy_types/1
  def update
    if @subsidy_type.dup_and_update(subsidy_type_params)
      redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /subsidy_types/1
  def destroy
    @subsidy_type.destroy
    redirect_to latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings), notice: t('.success')
  end

  def partial_view_subsidy_types
    @subsidy_types = SubsidyType.get_by_code
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsidy_type
      @subsidy_type = SubsidyType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subsidy_type_params
      params.require(:subsidy_type).permit(:name, :abbr_name, :code, :value_mode, :value, :for_all, :status, :kind, :cancel_url, :redirect_url, :is_taxed, {position_ids: [], function_ids: [], employee_ids: []})
    end
end
