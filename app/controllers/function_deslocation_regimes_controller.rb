class FunctionDeslocationRegimesController < ApplicationController
  before_action :set_function_deslocation_regime, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_deslocation_regimes
  def index
    @function_deslocation_regimes = FunctionDeslocationRegime.all
    @function_deslocation_regime = FunctionDeslocationRegime.new
    @function_deslocation_regime.cancel_and_redirect_url_to(function_deslocation_regimes_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_deslocation_regimes.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_deslocation_regimes/1
  def show
    @function_deslocation_regime.cancel_and_redirect_url_to(function_deslocation_regime_url(@function_deslocation_regime))
    respond_to do |f|
      f.html
      f.json { render json: @function_deslocation_regime.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_deslocation_regimes/new
  def new
    @function_deslocation_regime = FunctionDeslocationRegime.new
    @function_deslocation_regime.cancel_url = function_deslocation_regimes_url
    respond_to do |f|
      f.html
      f.json { render json: @function_deslocation_regime.as_json}
      f.js
    end
  end

  # GET /function_deslocation_regimes/1/edit
  def edit
    @function_deslocation_regime.cancel_and_redirect_url_to(function_deslocation_regime_url(@function_deslocation_regime))
    respond_to do |f|
      f.html
      f.json { render json: @function_deslocation_regime.as_json}
      f.js
    end
  end

  # POST /function_deslocation_regimes
  def create
    @function_deslocation_regime = FunctionDeslocationRegime.new(function_deslocation_regime_params)
    respond_to do |f|
      if @function_deslocation_regime.save
        f.html { redirect_to @function_deslocation_regime.redirect_url || redirect_url || function_deslocation_regime_url(@function_deslocation_regime), notice: controller_t('.saved') }
        f.json { render json: @function_deslocation_regime.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_deslocation_regime.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_deslocation_regimes/1
  def update
    respond_to do |f|
      if @function_deslocation_regime.update(function_deslocation_regime_params)
        f.html { redirect_to @function_deslocation_regime.redirect_url || redirect_url || function_deslocation_regime_url(@function_deslocation_regime), notice: controller_t('.updated') }
        f.json { render json: @function_deslocation_regime.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_deslocation_regime.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_deslocation_regimes/1
  def destroy
    @function_deslocation_regime.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_deslocation_regimes_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_deslocation_regime
      @function_deslocation_regime = FunctionDeslocationRegime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_deslocation_regime_params
      params.require(:function_deslocation_regime).permit(:name, :cancel_url, :redirect_url)
    end
end
