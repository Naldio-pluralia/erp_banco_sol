class SalaryLayersController < ApplicationController
  before_action :set_salary_layer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /salary_layers
  def index
    @salary_layers = SalaryLayer.all
    @salary_layer = SalaryLayer.new
    @salary_layer.cancel_and_redirect_url_to(salary_layers_url)
    respond_to do |f|
      f.html
      f.json { render json: @salary_layers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_layers/1
  def show
    @salary_layer.cancel_and_redirect_url_to(salary_layer_url(@salary_layer))
    respond_to do |f|
      f.html
      f.json { render json: @salary_layer.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /salary_layers/new
  def new
    @salary_layer = SalaryLayer.new
    @salary_layer.cancel_url = salary_layers_url
    respond_to do |f|
      f.html
      f.json { render json: @salary_layer.as_json}
      f.js
    end
  end

  # GET /salary_layers/1/edit
  def edit
    @salary_layer.cancel_and_redirect_url_to(salary_layer_url(@salary_layer))
    respond_to do |f|
      f.html
      f.json { render json: @salary_layer.as_json}
      f.js
    end
  end

  # POST /salary_layers
  def create
    @salary_layer = SalaryLayer.new(salary_layer_params)
    respond_to do |f|
      if @salary_layer.save
        f.html { redirect_to @salary_layer.redirect_url || redirect_url || salary_layer_url(@salary_layer), notice: controller_t('.saved') }
        f.json { render json: @salary_layer.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @salary_layer.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /salary_layers/1
  def update
    respond_to do |f|
      if @salary_layer.update(salary_layer_params)
        f.html { redirect_to @salary_layer.redirect_url || redirect_url || salary_layer_url(@salary_layer), notice: controller_t('.updated') }
        f.json { render json: @salary_layer.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @salary_layer.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /salary_layers/1
  def destroy
    @salary_layer.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || salary_layers_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_layer
      @salary_layer = SalaryLayer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_layer_params
      params.require(:salary_layer).permit(:name, :cancel_url, :redirect_url)
    end
end
