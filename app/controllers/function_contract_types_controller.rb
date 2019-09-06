class FunctionContractTypesController < ApplicationController
  before_action :set_function_contract_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_contract_types
  def index
    @function_contract_types = FunctionContractType.all
    @function_contract_type = FunctionContractType.new
    @function_contract_type.cancel_and_redirect_url_to(function_contract_types_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_contract_types.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_contract_types/1
  def show
    @function_contract_type.cancel_and_redirect_url_to(function_contract_type_url(@function_contract_type))
    respond_to do |f|
      f.html
      f.json { render json: @function_contract_type.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_contract_types/new
  def new
    @function_contract_type = FunctionContractType.new
    @function_contract_type.cancel_url = function_contract_types_url
    respond_to do |f|
      f.html
      f.json { render json: @function_contract_type.as_json}
      f.js
    end
  end

  # GET /function_contract_types/1/edit
  def edit
    @function_contract_type.cancel_and_redirect_url_to(function_contract_type_url(@function_contract_type))
    respond_to do |f|
      f.html
      f.json { render json: @function_contract_type.as_json}
      f.js
    end
  end

  # POST /function_contract_types
  def create
    @function_contract_type = FunctionContractType.new(function_contract_type_params)
    respond_to do |f|
      if @function_contract_type.save
        f.html { redirect_to @function_contract_type.redirect_url || redirect_url || function_contract_type_url(@function_contract_type), notice: controller_t('.saved') }
        f.json { render json: @function_contract_type.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_contract_type.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_contract_types/1
  def update
    respond_to do |f|
      if @function_contract_type.update(function_contract_type_params)
        f.html { redirect_to @function_contract_type.redirect_url || redirect_url || function_contract_type_url(@function_contract_type), notice: controller_t('.updated') }
        f.json { render json: @function_contract_type.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_contract_type.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_contract_types/1
  def destroy
    @function_contract_type.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_contract_types_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_contract_type
      @function_contract_type = FunctionContractType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_contract_type_params
      params.require(:function_contract_type).permit(:name, :cancel_url, :redirect_url)
    end
end
