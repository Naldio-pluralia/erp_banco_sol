class RemunerationSettingsController < ApplicationController
  before_action :set_remuneration_setting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # # GET /remuneration_settings
  # def index
  #   @remuneration_settings = RemunerationSetting.all
  #   # @remuneration_setting = RemunerationSetting.new
  # end

  # # GET /remuneration_settings/1
  # def show
  # end

  # GET /remuneration_settings/new
  def new
    @remuneration_setting = RemunerationSetting.new
  end

  # GET /remuneration_settings/1/edit
  def edit
  end

  # POST /remuneration_settings
  def create
    @remuneration_setting = RemunerationSetting.new(remuneration_setting_params)

    if @remuneration_setting.save
      redirect_to latest_remuneration_setting_url(tab_active: :tab_salary_settings), notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /remuneration_settings/1
  def update
    @remuneration_setting = @remuneration_setting.dup
    if @remuneration_setting.update(remuneration_setting_params)
      redirect_to @remuneration_setting, notice: t('.success')
    else
      render :edit
    end
  end

  # # DELETE /remuneration_settings/1
  # def destroy
  #   @remuneration_setting.destroy
  #   redirect_to remuneration_settings_url, notice: t('.success')
  # end

  def latest
    @remuneration_setting = RemunerationSetting.latest || RemunerationSetting.new
    @tax_types = TaxType.get_by_code
    @subsidy_types = SubsidyType.get_by_code
    @paygrade_change_reasons = PaygradeChangeReason.all

    @tax_type = TaxType.new
    @salary = Salary.new
    @tax_type.redirect_url = @tax_type.cancel_url = latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings)
    @salary.redirect_url = @salary.cancel_url = latest_remuneration_setting_url(active_tab: :tab_subsidy_and_tax_settings)
    @paygrade_change_reason = PaygradeChangeReason.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remuneration_setting
      @remuneration_setting = RemunerationSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def remuneration_setting_params
      params.require(:remuneration_setting).permit(:base_salary, :cancel_url, :update_factor, :redirect_url, :day_to_process_salaries, :month_to_process_christmas_subsidy)
    end
end
