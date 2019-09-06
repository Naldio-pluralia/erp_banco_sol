class EmployeeVacationsController < ApplicationController
  before_action :set_employee
  before_action :set_employee_vacation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_resource :employee
  load_and_authorize_resource only: [:show, :edit, :update, :destroy, :new, :index]
  layout :resolve_layout

  # GET /employee_vacations
  def index
    @employee_vacations = EmployeeVacation.all
    @employee_vacation = EmployeeVacation.new
    @employee_vacation.cancel_and_redirect_url_to(employee_vacations_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacations.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_vacations/1
  def show
    @employee_vacation.cancel_and_redirect_url_to(employee_vacation_url(@employee_vacation))
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_vacations/new
  def new
    @employee_vacation = EmployeeVacation.new
    @employee_vacation.cancel_url = employee_vacations_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation.as_json}
      f.js
    end
  end

  # GET /employee_vacations/1/edit
  def edit
    @employee_vacation.cancel_and_redirect_url_to(employee_vacation_url(@employee_vacation))
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation.as_json}
      f.js
    end
  end

  # POST /employee_vacations
  def create
    @employee_vacation = EmployeeVacation.new(employee_vacation_params)
    @employee_vacation.employee_id = current.employee&.id
    respond_to do |f|
      if @employee_vacation.save
        supervisor = @employee_vacation&.employee&.efective_position&.position&.efective
        Notification.new_notification(@employee_vacation.notification_vacation_message, supervisor, employee_vacation_url(@employee_vacation)) if supervisor.present?
        f.html { redirect_to @employee_vacation.redirect_url || redirect_url || employee_vacation_url(@employee_vacation), notice: controller_t('.saved') }
        f.json { render json: @employee_vacation.as_json}
        f.js { render :show }
      else
        p @employee_vacation.errors.messages
        f.html { render :new }
        f.json { render json: @employee_vacation.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_vacations/1
  def update
    respond_to do |f|
      if @employee_vacation.update(employee_vacation_params)
        f.html { redirect_to @employee_vacation.redirect_url || redirect_url || employee_vacation_url(@employee_vacation), notice: controller_t('.updated') }
        f.json { render json: @employee_vacation.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_vacation.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_vacations/1
  def destroy
    @employee_vacation.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_vacations_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def edit_vacation
    # @employee_vacation.cancel_and_redirect_url_to(employee_vacation_url(@employee_vacation))
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation.as_json}
      f.js
    end
  end

  def update_vacation
    respond_to do |f|
      if @employee_vacation.update(employee_vacation_params)
        f.html { redirect_to @employee_vacation.redirect_url || redirect_url || employee_vacation_url(@employee_vacation), notice: controller_t('.updated') }
        f.json { render json: @employee_vacation.as_json}
        f.js { render :show }
      else
        f.html { render :edit_vacation }
        f.json { render json: @employee_vacation.errors, status: :unprocessable_entity }
        f.js { render :edit_vacation }
      end
    end
  end

  def new_vacation
    @employee_vacation = EmployeeVacation.new(employee_id: @employee.id)

    @employee_vacation.cancel_url = employee_employee_vacations_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation.as_json}
      f.js
    end
  end

  def create_vacation
    @employee_vacation = EmployeeVacation.new(employee_vacation_params)
    @employee_vacation.employee_id = @employee.id
    respond_to do |f|
      if @employee_vacation.save
        Notification.new_notification(@employee_vacation.notification_vacation_message, @employee_vacation.employee, employee_vacation_url(@employee_vacation))
        f.html { redirect_to @employee_vacation.redirect_url || employee_vacation_url(@employee, @employee_vacation), notice: controller_t('.saved') }
        f.json { render json: @employee_vacation.as_json}
        f.js
      else
        p @employee_vacation.errors.messages
        f.html { render :new }
        f.json { render json: @employee_vacation.errors, status: :unprocessable_entity }
        f.js{render :new_vacation, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_vacation
      @employee_vacation = EmployeeVacation.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_vacation_params
      params.require(:employee_vacation).permit(:employee_id, :left_at, :returned_at, :number_of_days, :left_at_and_returned_at, :cancel_url, :redirect_url)
    end
end
