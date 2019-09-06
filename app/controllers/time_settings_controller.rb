class TimeSettingsController < ApplicationController
  before_action :set_time_setting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /time_settings
  def index
    @time_settings = TimeSetting.all
    @time_setting = TimeSetting.new
    @time_setting.cancel_and_redirect_url_to(time_settings_url)
    respond_to do |f|
      f.html
      f.json { render json: @time_settings.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /time_settings/1
  def show
    @time_setting.cancel_and_redirect_url_to(time_setting_url(@time_setting))
    respond_to do |f|
      f.html
      f.json { render json: @time_setting.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /time_settings/new
  def new
    @time_setting = TimeSetting.new
    @time_setting.cancel_url = time_settings_url
    respond_to do |f|
      f.html
      f.json { render json: @time_setting.as_json}
      f.js
    end
  end

  # GET /time_settings/1/edit
  def edit
    @time_setting.cancel_and_redirect_url_to(time_setting_url(@time_setting))
    respond_to do |f|
      f.html
      f.json { render json: @time_setting.as_json}
      f.js
    end
  end

  # POST /time_settings
  def create
    @time_setting = TimeSetting.new(time_setting_params)
    respond_to do |f|
      if @time_setting.save
        f.html { redirect_to @time_setting.redirect_url || redirect_url || time_setting_url(@time_setting), notice: controller_t('.saved') }
        f.json { render json: @time_setting.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @time_setting.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /time_settings/1
  def update
    respond_to do |f|
      if @time_setting.update(time_setting_params)
        f.html { redirect_to @time_setting.redirect_url || redirect_url || time_setting_url(@time_setting), notice: controller_t('.updated') }
        f.json { render json: @time_setting.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @time_setting.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /time_settings/1
  def destroy
    @time_setting.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || time_settings_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def latest
    @time_setting = TimeSetting.latest
    respond_to do |f|
      f.html
      f.json { render json: @time_setting.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_setting
      @time_setting = TimeSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_setting_params
      params.require(:time_setting).permit(:number_of_months_to_enjoy_vacation, :cancel_url, :redirect_url)
    end
end
