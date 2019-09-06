class FunctionAreasController < ApplicationController
  before_action :set_function_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_areas
  def index
    @function_areas = FunctionArea.all
    @function_area = FunctionArea.new
    @function_area.cancel_and_redirect_url_to(function_areas_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_areas.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_areas/1
  def show
    @function_area.cancel_and_redirect_url_to(function_area_url(@function_area))
    respond_to do |f|
      f.html
      f.json { render json: @function_area.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_areas/new
  def new
    @function_area = FunctionArea.new
    @function_area.cancel_url = function_areas_url
    respond_to do |f|
      f.html
      f.json { render json: @function_area.as_json}
      f.js
    end
  end

  # GET /function_areas/1/edit
  def edit
    @function_area.cancel_and_redirect_url_to(function_area_url(@function_area))
    respond_to do |f|
      f.html
      f.json { render json: @function_area.as_json}
      f.js
    end
  end

  # POST /function_areas
  def create
    @function_area = FunctionArea.new(function_area_params)
    respond_to do |f|
      if @function_area.save
        f.html { redirect_to @function_area.redirect_url || redirect_url || function_area_url(@function_area), notice: controller_t('.saved') }
        f.json { render json: @function_area.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_area.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_areas/1
  def update
    respond_to do |f|
      if @function_area.update(function_area_params)
        f.html { redirect_to @function_area.redirect_url || redirect_url || function_area_url(@function_area), notice: controller_t('.updated') }
        f.json { render json: @function_area.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_area.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_areas/1
  def destroy
    @function_area.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_areas_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_area
      @function_area = FunctionArea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_area_params
      params.require(:function_area).permit(:name, :cancel_url, :redirect_url)
    end
end
