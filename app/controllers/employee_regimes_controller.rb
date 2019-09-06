class EmployeeRegimesController < ApplicationController
  before_action :set_employee
  before_action :set_employee_regime, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_resource :employee
  load_and_authorize_resource :employee_regime, through: :employee
  layout :resolve_layout

  # GET /employee_regimes
  def index
    @employee_regimes = @employee.employee_regimes
    @employee_regime = EmployeeRegime.new
    @employee_regime.cancel_and_redirect_url_to(employee_employee_regimes_url(@employee))
    respond_to do |f|
      f.html
      f.json { render json: @employee_regimes.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_regimes/1
  def show
    @employee_regime.cancel_and_redirect_url_to(employee_employee_regime_url(@employee, @employee_regime))
    respond_to do |f|
      f.html
      f.json { render json: @employee_regime.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_regimes/new
  def new
    @employee_regime = EmployeeRegime.new
    @employee_regime.cancel_url = employee_employee_regimes_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_regime.as_json}
      f.js
    end
  end

  # GET /employee_regimes/1/edit
  def edit
    @employee_regime.cancel_and_redirect_url_to(employee_employee_regime_url(@employee, @employee_regime))
    respond_to do |f|
      f.html
      f.json { render json: @employee_regime.as_json}
      f.js
    end
  end

  # POST /employee_regimes
  def create
    @employee_regime = EmployeeRegime.new(employee_regime_params)
    @employee_regime.employee_id = @employee.id
    respond_to do |f|
      if @employee_regime.save
        f.html { redirect_to @employee_regime.redirect_url || employee_employee_regime_url(@employee, @employee_regime), notice: controller_t('.saved') }
        f.json { render json: @employee_regime.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_regime.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_regimes/1
  def update
    respond_to do |f|
      if @employee_regime.update(employee_regime_params)
        f.html { redirect_to @employee_regime.redirect_url || employee_employee_regime_url(@employee, @employee_regime), notice: controller_t('.updated') }
        f.json { render json: @employee_regime.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_regime.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_regimes/1
  def destroy
    @employee_regime.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_employee_regimes_url(@employee), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_regime
      @employee_regime = EmployeeRegime.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_regime_params
      params.require(:employee_regime).permit(:regime, :enters_at, :leaves_at, :employee_id, :cancel_url, :redirect_url)
    end
end
