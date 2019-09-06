class SalaryCategoriesController < ApplicationController
  before_action :set_salary_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_categories
  def index
    @salary_categories = SalaryCategory.all
    @salary_category = SalaryCategory.new
    @salary_category.cancel_and_redirect_url_to(salary_categories_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_categories.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_categories/1
  def show
    @salary_category.cancel_and_redirect_url_to(salary_category_url(@salary_category))
    respond_to do |f|
      f.html
      f.json { render json: @salary_category.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_categories/new
  def new
    @salary_category = SalaryCategory.new
    @salary_category.cancel_url = salary_categories_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_category.as_json}
      f.js
    end
  end

  # GET /salary_categories/1/edit
  def edit
    @salary_category.cancel_and_redirect_url_to(salary_category_url(@salary_category))
    respond_to do |f|
      f.html
      f.json { render json: @salary_category.as_json}
      f.js
    end
  end

  # POST /salary_categories
  def create
    @salary_category = SalaryCategory.new(salary_category_params)
    respond_to do |f|
      if @salary_category.save
        f.html { redirect_to @salary_category.redirect_url || redirect_url || salary_category_url(@salary_category), notice: controller_t('.saved') }
        f.json { render json: @salary_category.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_category.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_categories/1
  def update
    respond_to do |f|
      if @salary_category.update(salary_category_params)
        f.html { redirect_to @salary_category.redirect_url || redirect_url || salary_category_url(@salary_category), notice: controller_t('.updated') }
        f.json { render json: @salary_category.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_category.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_categories/1
  def destroy
    @salary_category.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || salary_categories_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_category
      @salary_category = SalaryCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_category_params
      params.require(:salary_category).permit(:name, :cancel_url, :redirect_url)
    end
end
