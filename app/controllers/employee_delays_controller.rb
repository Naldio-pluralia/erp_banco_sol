class EmployeeDelaysController < ApplicationController
  before_action :set_employee
  before_action :set_employee_delay, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_resource :employee
  load_and_authorize_resource :employee_delay, through: :employee
  layout :resolve_layout

  # GET /employee_delays
  def index
    @employee_delays = EmployeeDelay.all
    @employee_delay = EmployeeDelay.new
    @employee_delay.cancel_and_redirect_url_to(employee_employee_delays_url(@employee))
    respond_to do |f|
      f.html
      f.json { render json: @employee_delays.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_delays/1
  def show
    @employee_delay.cancel_and_redirect_url_to(employee_employee_delay_url(@employee, @employee_delay))
    respond_to do |f|
      f.html
      f.json { render json: @employee_delay.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_delays/new
  def new
    @employee_delay = EmployeeDelay.new
    @employee_delay.cancel_url = employee_employee_delays_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_delay.as_json}
      f.js
    end
  end

  # GET /employee_delays/1/edit
  def edit
    @employee_delay.cancel_and_redirect_url_to(employee_employee_delay_url(@employee, @employee_delay))
    respond_to do |f|
      f.html
      f.json { render json: @employee_delay.as_json}
      f.js
    end
  end

  # POST /employee_delays
  def create
    @employee_delay = EmployeeDelay.new(employee_delay_params)
    @employee_delay.employee_id = @employee.id
    respond_to do |f|
      if @employee_delay.save
        supervisor = @employee_delay&.employee&.efective_position&.position&.efective
        Notification.new_notification(@employee_delay.notification_delay_message, supervisor, '/#') if supervisor.present?
        f.html { redirect_to @employee_delay.redirect_url || employee_employee_delay_url(@employee, @employee_delay), notice: controller_t('.saved') }
        f.json { render json: @employee_delay.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_delay.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_delays/1
  def update
    respond_to do |f|
      if @employee_delay.update(employee_delay_params)
        f.html { redirect_to @employee_delay.redirect_url || employee_employee_delay_url(@employee, @employee_delay), notice: controller_t('.updated') }
        f.json { render json: @employee_delay.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_delay.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_delays/1
  def destroy
    @employee_delay.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_employee_delays_url(@employee), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def new_delay
    @employee_delay = EmployeeDelay.new
    @employee_delay.cancel_url = employee_employee_delays_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_delay.as_json}
      f.js
    end
  end

  def create_delay
    @employee_delay = EmployeeDelay.new(employee_delay_params)
    @employee_delay.employee_id = @employee.id
    respond_to do |f|
      if @employee_delay.save
        Notification.new_notification(@employee_delay.notification_delay_message, @employee_delay.employee, employee_employee_delay_url(@employee, @employee_delay))
        f.html { redirect_to @employee_delay.redirect_url || employee_employee_delay_url(@employee, @employee_delay), notice: controller_t('.saved') }
        f.json { render json: @employee_delay.as_json}
        f.js
      else
        p @employee_delay.errors.messages
        f.html { render :new }
        f.json { render json: @employee_delay.errors, status: :unprocessable_entity }
        f.js{render :new_delay, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_delay
      @employee_delay = EmployeeDelay.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_delay_params
      params.require(:employee_delay).permit(:employee_id, :absence_type_id, :date, :arrived_at, :number_of_hours_late, :cancel_url, :redirect_url)
    end
end
