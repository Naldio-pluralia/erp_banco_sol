class FunctionSettingsController < ApplicationController
  before_action :set_function_setting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_settings
  def index
    @function_settings = FunctionSetting.all
    @function_setting = FunctionSetting.new
    @function_setting.cancel_and_redirect_url_to(function_settings_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_settings.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_settings/1
  def show
    @function_setting.cancel_and_redirect_url_to(function_setting_url(@function_setting))
    respond_to do |f|
      f.html
      f.json { render json: @function_setting.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_settings/new
  def new
    @function_setting = FunctionSetting.new
    @function_setting.cancel_url = function_settings_url
    respond_to do |f|
      f.html
      f.json { render json: @function_setting.as_json}
      f.js
    end
  end

  # GET /function_settings/1/edit
  def edit
    @function_setting.cancel_and_redirect_url_to(function_setting_url(@function_setting))
    respond_to do |f|
      f.html
      f.json { render json: @function_setting.as_json}
      f.js
    end
  end

  # POST /function_settings
  def create
    @function_setting = FunctionSetting.new(function_setting_params)
    respond_to do |f|
      if @function_setting.save
        f.html { redirect_to @function_setting.redirect_url || redirect_url || function_setting_url(@function_setting), notice: controller_t('.saved') }
        f.json { render json: @function_setting.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_setting.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_settings/1
  def update
    respond_to do |f|
      if @function_setting.update(function_setting_params)
        f.html { redirect_to @function_setting.redirect_url || redirect_url || function_setting_url(@function_setting), notice: controller_t('.updated') }
        f.json { render json: @function_setting.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_setting.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_settings/1
  def destroy
    @function_setting.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || function_settings_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_setting
      @function_setting = FunctionSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_setting_params
      params.require(:function_setting).permit(:max_chairman_number, :maximum_objective_number, :cancel_url, :redirect_url)
    end
end
