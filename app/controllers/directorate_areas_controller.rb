class DirectorateAreasController < ApplicationController
  before_action :set_directorate_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /directorate_areas
  def index
    @directorate_areas = DirectorateArea.all
    @directorate_area = DirectorateArea.new
    @directorate_area.cancel_and_redirect_url_to(directorate_areas_url)
    respond_to do |f|
      f.html
      f.json { render json: @directorate_areas.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /directorate_areas/1
  def show
    @directorate_area.cancel_and_redirect_url_to(directorate_area_url(@directorate_area))
    respond_to do |f|
      f.html
      f.json { render json: @directorate_area.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /directorate_areas/new
  def new
    @directorate_area = DirectorateArea.new
    @directorate_area.cancel_url = directorate_areas_url
    respond_to do |f|
      f.html
      f.json { render json: @directorate_area.as_json}
      f.js
    end
  end

  # GET /directorate_areas/1/edit
  def edit
    @directorate_area.cancel_and_redirect_url_to(directorate_area_url(@directorate_area))
    respond_to do |f|
      f.html
      f.json { render json: @directorate_area.as_json}
      f.js
    end
  end

  # POST /directorate_areas
  def create
    @directorate_area = DirectorateArea.new(directorate_area_params)
    respond_to do |f|
      if @directorate_area.save
        f.html { redirect_to @directorate_area.redirect_url || redirect_url || directorate_area_url(@directorate_area), notice: controller_t('.saved') }
        f.json { render json: @directorate_area.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @directorate_area.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /directorate_areas/1
  def update
    respond_to do |f|
      if @directorate_area.update(directorate_area_params)
        f.html { redirect_to @directorate_area.redirect_url || redirect_url || directorate_area_url(@directorate_area), notice: controller_t('.updated') }
        f.json { render json: @directorate_area.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @directorate_area.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /directorate_areas/1
  def destroy
    @directorate_area.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || directorate_areas_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directorate_area
      @directorate_area = DirectorateArea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def directorate_area_params
      params.require(:directorate_area).permit(:name, :cancel_url, :redirect_url)
    end
end
