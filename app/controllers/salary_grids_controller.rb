class SalaryGridsController < ApplicationController
  before_action :set_salary_grid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_grids
  def index
    @salary_grids = SalaryGrid.latest.order(number: :desc)
    @salary_grid = SalaryGrid.new
    @salary_grid.cancel_and_redirect_url_to(salary_grids_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_grids.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_grids/1
  def show
    @salary_grid.cancel_and_redirect_url_to(salary_grid_url(@salary_grid))
    respond_to do |f|
      f.html
      f.json { render json: @salary_grid.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_grids/new
  def new
    @salary_grid = SalaryGrid.new
    @salary_grid.cancel_url = salary_grids_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_grid.as_json}
      f.js
    end
  end

  # GET /salary_grids/1/edit
  def edit
    @salary_grid.cancel_and_redirect_url_to(salary_grid_url(@salary_grid))
    respond_to do |f|
      f.html
      f.json { render json: @salary_grid.as_json}
      f.js
    end
  end

  # POST /salary_grids
  def create
    @salary_grid = SalaryGrid.new(salary_grid_params)
    respond_to do |f|
      if @salary_grid.save
        f.html { redirect_to @salary_grid.redirect_url || redirect_url || salary_grid_url(@salary_grid), notice: controller_t('.saved') }
        f.json { render json: @salary_grid.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_grid.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_grids/1
  def update
    respond_to do |f|
      if @salary_grid.update(salary_grid_params)
        f.html { redirect_to @salary_grid.redirect_url || redirect_url || salary_grid_url(@salary_grid), notice: controller_t('.updated') }
        f.json { render json: @salary_grid.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_grid.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_grids/1
  def destroy
    @salary_grid.destroy
    
    respond_to do |f|
      f.html { redirect_to salary_grids_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def add_grid
    latest_grids = SalaryGrid.latest.to_a
    last_code = (latest_grids.last&.code || 0) + 1
    last_number = (latest_grids.map(&:number).sort.last || 0) + 1
    base_value = RemunerationSetting.last&.base_salary
    update_factor = RemunerationSetting.last&.update_factor
    
    SalaryGrid.create((1..last_number).map{|number| {number: number, code: last_code}})
    SalaryFamily.latest.update_families
    respond_to do |f|
      f.html {redirect_to latest_remuneration_setting_url(active_tab: :tab_salary_grids), notice: controller_t('.grid_added')}
      f.json { render json: @salary_grids.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def remove_grid
    latest_grids = SalaryGrid.latest.to_a
    last_code = (latest_grids.last&.code || 0) + 1
    last_number = (latest_grids.last&.number || 0) - 1
    last_number = 1 if last_number < 1
    base_value = RemunerationSetting.last&.base_salary
    update_factor = RemunerationSetting.last&.update_factor
    
    SalaryGrid.create((1..last_number).map{|number| {number: number, code: last_code}})
    SalaryFamily.latest.update_families
    respond_to do |f|
      f.html {redirect_to latest_remuneration_setting_url(active_tab: :tab_salary_grids), notice: controller_t('.grid_removed')}
      f.json { render json: @salary_grids.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_grid
      @salary_grid = SalaryGrid.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_grid_params
      params.require(:salary_grid).permit(:number, :code, :value_80, :value_100, :value_105, :value_110, :value_115, :value_120, :value_125, :cancel_url, :redirect_url)
    end
end
