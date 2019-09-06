class EmployeeAvaliableVacationsController < ApplicationController
  before_action :set_employee_avaliable_vacation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_avaliable_vacations
  def index
    @employee_avaliable_vacations = EmployeeAvaliableVacation.all
    @employee_avaliable_vacation = EmployeeAvaliableVacation.new
    @employee_avaliable_vacation.cancel_and_redirect_url_to(employee_avaliable_vacations_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_avaliable_vacations.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_avaliable_vacations/1
  def show
    @employee_avaliable_vacation.cancel_and_redirect_url_to(employee_avaliable_vacation_url(@employee_avaliable_vacation))
    respond_to do |f|
      f.html
      f.json { render json: @employee_avaliable_vacation.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_avaliable_vacations/new
  def new
    @employee_avaliable_vacation = EmployeeAvaliableVacation.new
    @employee_avaliable_vacation.cancel_url = employee_avaliable_vacations_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_avaliable_vacation.as_json}
      f.js
    end
  end

  # GET /employee_avaliable_vacations/1/edit
  def edit
    @employee_avaliable_vacation.cancel_and_redirect_url_to(employee_avaliable_vacation_url(@employee_avaliable_vacation))
    respond_to do |f|
      f.html
      f.json { render json: @employee_avaliable_vacation.as_json}
      f.js
    end
  end

  # POST /employee_avaliable_vacations
  def create
    @employee_avaliable_vacation = EmployeeAvaliableVacation.new(employee_avaliable_vacation_params)
    respond_to do |f|
      if @employee_avaliable_vacation.save
        f.html { redirect_to @employee_avaliable_vacation.redirect_url || redirect_url || employee_avaliable_vacation_url(@employee_avaliable_vacation), notice: controller_t('.saved') }
        f.json { render json: @employee_avaliable_vacation.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_avaliable_vacation.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_avaliable_vacations/1
  def update
    respond_to do |f|
      if @employee_avaliable_vacation.update(employee_avaliable_vacation_params)
        f.html { redirect_to @employee_avaliable_vacation.redirect_url || redirect_url || employee_avaliable_vacation_url(@employee_avaliable_vacation), notice: controller_t('.updated') }
        f.json { render json: @employee_avaliable_vacation.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_avaliable_vacation.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_avaliable_vacations/1
  def destroy
    @employee_avaliable_vacation.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_avaliable_vacations_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_avaliable_vacation
      @employee_avaliable_vacation = EmployeeAvaliableVacation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_avaliable_vacation_params
      params.require(:employee_avaliable_vacation).permit(:employee_id, :date, :number_of_days, :valid_until, :cancel_url, :redirect_url)
    end
end
