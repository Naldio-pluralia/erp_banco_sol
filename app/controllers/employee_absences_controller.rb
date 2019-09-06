class EmployeeAbsencesController < ApplicationController
  before_action :set_employee
  before_action :set_employee_absence, only: [:show, :edit, :update, :destroy, :mark_presence, :mark_employee_presence]
  before_action :authenticate_account!
  load_resource :employee
  load_and_authorize_resource :employee_absence, through: :employee
  layout :resolve_layout

  # GET /employee_absences
  def index
    @employee_absences = EmployeeAbsence.all
    @employee_absence = EmployeeAbsence.new(employee_id: @employee.id)
    @employee_absence.cancel_and_redirect_url_to(employee_employee_absences_url(@employee))
    respond_to do |f|
      f.html
      f.json { render json: @employee_absences.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_absences/1
  def show
    @employee_absence.cancel_and_redirect_url_to(employee_employee_absence_url(@employee, @employee_absence))
    respond_to do |f|
      f.html
      f.json { render json: @employee_absence.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_absences/new
  def new
    @employee_absence = EmployeeAbsence.new(employee_id: @employee.id)
    @employee_absence.cancel_url = employee_employee_absences_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_absence.as_json}
      f.js
    end
  end

  # GET /employee_absences/1/edit
  def edit
    @employee_absence.cancel_and_redirect_url_to(employee_employee_absence_url(@employee, @employee_absence))
    respond_to do |f|
      f.html
      f.json { render json: @employee_absence.as_json}
      f.js
    end
  end

  # POST /employee_absences
  def create
    @employee_absence = EmployeeAbsence.new(employee_absence_params)
    @employee_absence.employee_id = @employee.id
    respond_to do |f|
      if @employee_absence.save
        supervisor = @employee_absence&.employee&.efective_position&.position&.efective
        Notification.new_notification(@employee_absence.notification_absence_message, supervisor, '/#') if supervisor.present?
        f.html { redirect_to @employee_absence.redirect_url || employee_employee_absence_url(@employee, @employee_absence), notice: controller_t('.saved') }
        f.json { render json: @employee_absence.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_absence.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_absences/1
  def update
    respond_to do |f|
      if @employee_absence.update(employee_absence_params)
        f.html { redirect_to @employee_absence.redirect_url || employee_employee_absence_url(@employee, @employee_absence), notice: controller_t('.updated') }
        f.json { render json: @employee_absence.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_absence.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_absences/1
  def destroy
    @employee_absence.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_employee_absences_url(@employee), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def new_absence
    @employee_absence = EmployeeAbsence.new(employee_id: @employee.id)
    @employee_absence.cancel_url = employee_employee_absences_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_absence.as_json}
      f.js
    end
  end

  def create_absence
    @employee_absence = EmployeeAbsence.new(employee_absence_params)
    @employee_absence.employee_id = @employee.id
    respond_to do |f|
      if @employee_absence.save
        Notification.new_notification(@employee_absence.notification_absence_message, @employee_absence.employee, employee_employee_absence_url(@employee, @employee_absence))
        f.html { redirect_to @employee_absence.redirect_url || employee_employee_absence_url(@employee, @employee_absence), notice: controller_t('.saved') }
        f.json { render json: @employee_absence.as_json}
        f.js
      else
        f.html { render :new }
        f.json { render json: @employee_absence.errors, status: :unprocessable_entity }
        f.js{render :new_absence, status: :unprocessable_entity}
      end
    end
  end

  def mark_presence
    if current.position.present? && current.position.position.present?
      status = 0
    else
      status = 1
    end
    data = @employee_absence.absence_days.map{|absence| {date: absence.date, employee_id: @employee_absence.employee_id, status: status}}
    @employee_absence.destroy
    EmployeePresence.create(data)
    respond_to do |f|
      f.html { redirect_to redirect_url, notice: controller_t('.saved') }
      f.js
    end
  end

  def mark_employee_presence
    data = @employee_absence.absence_days.map{|absence| {date: absence.date, employee_id: @employee_absence.employee_id, status: 1}}
    @employee_absence.destroy
    EmployeePresence.create(data) if @employee_absence.destroyed?
    respond_to do |f|
      f.html { render 'nextsgad/employees/presence' }
      f.js
      f.json { render json: @employee_absence.as_json}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_absence
      @employee_absence = EmployeeAbsence.where(employee_id: @employee.id).find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_absence_params
      params.require(:employee_absence).permit(:employee_id, :absence_type_id, :returned_at, :left_at, :absent_days_number, :cancel_url, :redirect_url)
    end
end
