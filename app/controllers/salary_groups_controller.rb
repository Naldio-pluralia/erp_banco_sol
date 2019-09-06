class SalaryGroupsController < ApplicationController
  before_action :set_salary_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_groups
  def index
    @salary_groups = SalaryGroup.all
    @salary_group = SalaryGroup.new
    @salary_group.cancel_and_redirect_url_to(salary_groups_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_groups.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_groups/1
  def show
    @salary_group.cancel_and_redirect_url_to(salary_group_url(@salary_group))
    respond_to do |f|
      f.html
      f.json { render json: @salary_group.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_groups/new
  def new
    @salary_group = SalaryGroup.new
    @salary_group.cancel_url = salary_groups_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_group.as_json}
      f.js
    end
  end

  # GET /salary_groups/1/edit
  def edit
    @salary_group.cancel_and_redirect_url_to(salary_group_url(@salary_group))
    respond_to do |f|
      f.html
      f.json { render json: @salary_group.as_json}
      f.js
    end
  end

  # POST /salary_groups
  def create
    @salary_group = SalaryGroup.new(salary_group_params)
    respond_to do |f|
      if @salary_group.save
        f.html { redirect_to @salary_group.redirect_url || redirect_url || salary_group_url(@salary_group), notice: controller_t('.saved') }
        f.json { render json: @salary_group.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_group.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_groups/1
  def update
    respond_to do |f|
      if @salary_group.update(salary_group_params)
        f.html { redirect_to @salary_group.redirect_url || redirect_url || salary_group_url(@salary_group), notice: controller_t('.updated') }
        f.json { render json: @salary_group.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_group.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_groups/1
  def destroy
    @salary_group.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || salary_groups_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_group
      @salary_group = SalaryGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_group_params
      params.require(:salary_group).permit(:name, :cancel_url, :redirect_url)
    end
end
