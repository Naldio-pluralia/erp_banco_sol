class SalaryFamiliesController < ApplicationController
  before_action :set_salary_family, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_families
  def index
    @salary_families = SalaryFamily.all
    @salary_family = SalaryFamily.new
    @salary_family.cancel_and_redirect_url_to(salary_families_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_families.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_families/1
  def show
    @salary_family.cancel_and_redirect_url_to(salary_family_url(@salary_family))
    respond_to do |f|
      f.html
      f.json { render json: @salary_family.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_families/new
  def new
    @salary_family = SalaryFamily.new
    @salary_family.cancel_url = salary_families_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_family.as_json}
      f.js
    end
  end

  # GET /salary_families/1/edit
  def edit
    @salary_family.cancel_and_redirect_url_to(salary_family_url(@salary_family))
    respond_to do |f|
      f.html
      f.json { render json: @salary_family.as_json}
      f.js
    end
  end

  # POST /salary_families
  def create
    @salary_family = SalaryFamily.new(salary_family_params)
    @salary_family.code = (SalaryFamily.maximum(:code) || 0) + 1
    respond_to do |f|
      if @salary_family.save
        @salary_family.add_family
        f.html { redirect_to @salary_family.redirect_url || redirect_url || latest_remuneration_setting_url(active_tab: :tab_salary_families), notice: controller_t('.saved') }
        f.json { render json: @salary_family.as_json }
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_family.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_families/1
  def update
    respond_to do |f|
      if @salary_family.update(salary_family_params)
        f.html { redirect_to @salary_family.redirect_url || redirect_url || salary_family_url(@salary_family), notice: controller_t('.updated') }
        f.json { render json: @salary_family.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_family.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_families/1
  def destroy
    @salary_family.remove_family
    respond_to do |f|
      f.html { redirect_to latest_remuneration_setting_url(active_tab: :tab_salary_families), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_family
      @salary_family = SalaryFamily.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_family_params
      params.require(:salary_family).permit(:code, :salary_grid_id, :salary_category_id, :salary_area_id, :family, :salary_layer_id, :salary_group_id, :core, :cancel_url, :redirect_url)
    end
end
