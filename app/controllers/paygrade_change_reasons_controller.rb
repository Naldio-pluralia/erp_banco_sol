class PaygradeChangeReasonsController < ApplicationController
  before_action :set_paygrade_change_reason, only: [:show, :edit, :update, :destroy]
  layout "partial_view_application", only: [:partial_view_paygrade_change_reasons]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /paygrade_change_reasons
  def index
    @paygrade_change_reasons = PaygradeChangeReason.all
    @paygrade_change_reason = PaygradeChangeReason.new
  end

  # GET /paygrade_change_reasons/1
  def show
  end

  # GET /paygrade_change_reasons/new
  def new
    @paygrade_change_reason = PaygradeChangeReason.new
  end

  # # GET /paygrade_change_reasons/1/edit
  # def edit
  # end

  # POST /paygrade_change_reasons
  def create
    @paygrade_change_reason = PaygradeChangeReason.new(paygrade_change_reason_params)

    if @paygrade_change_reason.save
      redirect_to latest_remuneration_setting_url(active_tab: :tab_paygrade_change_settings), notice: t('.success')
    else
      render :new
    end
  end

  # # PATCH/PUT /paygrade_change_reasons/1
  # def update
  #   if @paygrade_change_reason.update(paygrade_change_reason_params)
  #     redirect_to @paygrade_change_reason, notice: t('.success')
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /paygrade_change_reasons/1
  def destroy
    @paygrade_change_reason.destroy
    redirect_to latest_remuneration_setting_url(active_tab: :tab_paygrade_change_settings), notice: t('.success')
  end

  def partial_view_paygrade_change_reasons
    @paygrade_change_reasons = PaygradeChangeReason.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paygrade_change_reason
      @paygrade_change_reason = PaygradeChangeReason.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paygrade_change_reason_params
      params.require(:paygrade_change_reason).permit(:reason, :cancel_url, :redirect_url)
    end
end
