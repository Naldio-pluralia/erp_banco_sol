class SalaryAreasController < ApplicationController
  before_action :set_salary_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_areas
  def index
    @salary_areas = SalaryArea.all
    @salary_area = SalaryArea.new
    @salary_area.cancel_and_redirect_url_to(salary_areas_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_areas.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_areas/1
  def show
    @salary_area.cancel_and_redirect_url_to(salary_area_url(@salary_area))
    respond_to do |f|
      f.html
      f.json { render json: @salary_area.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_areas/new
  def new
    @salary_area = SalaryArea.new
    @salary_area.cancel_url = salary_areas_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_area.as_json}
      f.js
    end
  end

  # GET /salary_areas/1/edit
  def edit
    @salary_area.cancel_and_redirect_url_to(salary_area_url(@salary_area))
    respond_to do |f|
      f.html
      f.json { render json: @salary_area.as_json}
      f.js
    end
  end

  # POST /salary_areas
  def create
    @salary_area = SalaryArea.new(salary_area_params)
    respond_to do |f|
      if @salary_area.save
        f.html { redirect_to @salary_area.redirect_url || redirect_url || salary_area_url(@salary_area), notice: controller_t('.saved') }
        f.json { render json: @salary_area.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_area.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_areas/1
  def update
    respond_to do |f|
      if @salary_area.update(salary_area_params)
        f.html { redirect_to @salary_area.redirect_url || redirect_url || salary_area_url(@salary_area), notice: controller_t('.updated') }
        f.json { render json: @salary_area.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_area.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_areas/1
  def destroy
    @salary_area.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || salary_areas_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_area
      @salary_area = SalaryArea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_area_params
      params.require(:salary_area).permit(:name, :cancel_url, :redirect_url)
    end
end
