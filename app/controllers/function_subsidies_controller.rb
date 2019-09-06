class FunctionSubsidiesController < ApplicationController
  before_action :set_function_subsidy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_subsidies
  def index
    @function_subsidies = FunctionSubsidy.all
    @function_subsidy = FunctionSubsidy.new
    @function_subsidy.cancel_and_redirect_url_to(function_subsidies_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_subsidies.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_subsidies/1
  def show
    @function_subsidy.cancel_and_redirect_url_to(function_subsidy_url(@function_subsidy))
    respond_to do |f|
      f.html
      f.json { render json: @function_subsidy.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_subsidies/new
  def new
    @function_subsidy = FunctionSubsidy.new
    @function_subsidy.cancel_url = function_subsidies_url
    respond_to do |f|
      f.html
      f.json { render json: @function_subsidy.as_json}
      f.js
    end
  end

  # GET /function_subsidies/1/edit
  def edit
    @function_subsidy.cancel_and_redirect_url_to(function_subsidy_url(@function_subsidy))
    respond_to do |f|
      f.html
      f.json { render json: @function_subsidy.as_json}
      f.js
    end
  end

  # POST /function_subsidies
  def create
    @function_subsidy = FunctionSubsidy.new(function_subsidy_params)
    respond_to do |f|
      if @function_subsidy.save
        f.html { redirect_to @function_subsidy.redirect_url || redirect_url || function_subsidy_url(@function_subsidy), notice: controller_t('.saved') }
        f.json { render json: @function_subsidy.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_subsidy.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_subsidies/1
  def update
    respond_to do |f|
      if @function_subsidy.update(function_subsidy_params)
        f.html { redirect_to @function_subsidy.redirect_url || redirect_url || function_subsidy_url(@function_subsidy), notice: controller_t('.updated') }
        f.json { render json: @function_subsidy.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_subsidy.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_subsidies/1
  def destroy
    @function_subsidy.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_subsidies_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_subsidy
      @function_subsidy = FunctionSubsidy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_subsidy_params
      params.require(:function_subsidy).permit(:name, :cancel_url, :redirect_url)
    end
end
