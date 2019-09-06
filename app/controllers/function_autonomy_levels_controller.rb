class FunctionAutonomyLevelsController < ApplicationController
  before_action :set_function_autonomy_level, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_autonomy_levels
  def index
    @function_autonomy_levels = FunctionAutonomyLevel.all
    @function_autonomy_level = FunctionAutonomyLevel.new
    @function_autonomy_level.cancel_and_redirect_url_to(function_autonomy_levels_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_autonomy_levels.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_autonomy_levels/1
  def show
    @function_autonomy_level.cancel_and_redirect_url_to(function_autonomy_level_url(@function_autonomy_level))
    respond_to do |f|
      f.html
      f.json { render json: @function_autonomy_level.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_autonomy_levels/new
  def new
    @function_autonomy_level = FunctionAutonomyLevel.new
    @function_autonomy_level.cancel_url = function_autonomy_levels_url
    respond_to do |f|
      f.html
      f.json { render json: @function_autonomy_level.as_json}
      f.js
    end
  end

  # GET /function_autonomy_levels/1/edit
  def edit
    @function_autonomy_level.cancel_and_redirect_url_to(function_autonomy_level_url(@function_autonomy_level))
    respond_to do |f|
      f.html
      f.json { render json: @function_autonomy_level.as_json}
      f.js
    end
  end

  # POST /function_autonomy_levels
  def create
    @function_autonomy_level = FunctionAutonomyLevel.new(function_autonomy_level_params)
    respond_to do |f|
      if @function_autonomy_level.save
        f.html { redirect_to @function_autonomy_level.redirect_url || redirect_url || function_autonomy_level_url(@function_autonomy_level), notice: controller_t('.saved') }
        f.json { render json: @function_autonomy_level.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_autonomy_level.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_autonomy_levels/1
  def update
    respond_to do |f|
      if @function_autonomy_level.update(function_autonomy_level_params)
        f.html { redirect_to @function_autonomy_level.redirect_url || redirect_url || function_autonomy_level_url(@function_autonomy_level), notice: controller_t('.updated') }
        f.json { render json: @function_autonomy_level.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_autonomy_level.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_autonomy_levels/1
  def destroy
    @function_autonomy_level.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_autonomy_levels_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_autonomy_level
      @function_autonomy_level = FunctionAutonomyLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_autonomy_level_params
      params.require(:function_autonomy_level).permit(:name, :cancel_url, :redirect_url)
    end
end
