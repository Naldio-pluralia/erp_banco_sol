class EmployeeExitsController < ApplicationController
  before_action :set_employee
  before_action :set_employee_exit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_resource :employee
  load_and_authorize_resource :employee_exit, through: :employee
  layout :resolve_layout

  # GET /employee_exits
  def index
    @employee_exits = EmployeeExit.all
    @employee_exit = EmployeeExit.new(employee_id: @employee.id)
    @employee_exit.cancel_and_redirect_url_to(employee_employee_exits_url(@employee))
    respond_to do |f|
      f.html
      f.json { render json: @employee_exits.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_exits/1
  def show
    @employee_exit.cancel_and_redirect_url_to(employee_employee_exit_url(@employee, @employee_exit))
    respond_to do |f|
      f.html
      f.json { render json: @employee_exit.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_exits/new
  def new
    @employee_exit = EmployeeExit.new(employee_id: @employee.id)
    @employee_exit.cancel_url = employee_employee_exits_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_exit.as_json}
      f.js
    end
  end

  # GET /employee_exits/1/edit
  def edit
    @employee_exit.cancel_and_redirect_url_to(employee_employee_exit_url(@employee, @employee_exit))
    respond_to do |f|
      f.html
      f.json { render json: @employee_exit.as_json}
      f.js
    end
  end

  # POST /employee_exits
  def create
    @employee_exit = EmployeeExit.new(employee_exit_params)
    @employee_exit.employee_id = @employee.id
    respond_to do |f|
      if @employee_exit.save
        supervisor = @employee_exit&.employee&.efective_position&.position&.efective
        Notification.new_notification(@employee_exit.notification_exit_message, supervisor, '/#') if supervisor.present?
        f.html { redirect_to @employee_exit.redirect_url || employee_employee_exit_url(@employee, @employee_exit), notice: controller_t('.saved') }
        f.json { render json: @employee_exit.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_exit.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_exits/1
  def update
    respond_to do |f|
      if @employee_exit.update(employee_exit_params)
        f.html { redirect_to @employee_exit.redirect_url || employee_employee_exit_url(@employee, @employee_exit), notice: controller_t('.updated') }
        f.json { render json: @employee_exit.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_exit.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_exits/1
  def destroy
    @employee_exit.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_employee_exits_url(@employee), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def new_exit
    @employee_exit = EmployeeExit.new(employee_id: @employee.id)
    @employee_exit.cancel_url = employee_employee_exits_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_exit.as_json}
      f.js
    end
  end

  def create_exit
    @employee_exit = EmployeeExit.new(employee_exit_params)
    @employee_exit.employee_id = @employee.id
    respond_to do |f|
      if @employee_exit.save
        Notification.new_notification(@employee_exit.notification_exit_message, @employee_exit.employee, employee_employee_exit_url(@employee, @employee_exit))
        f.html { redirect_to @employee_exit.redirect_url || employee_employee_exit_url(@employee, @employee_exit), notice: controller_t('.saved') }
        f.json { render json: @employee_exit.as_json}
        f.js
      else
        p '----------------------'
        f.html { render :new }
        f.json { render json: @employee_exit.errors, status: :unprocessable_entity }
        f.js{render :new_exit, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_exit
      @employee_exit = EmployeeExit.where(employee_id: @employee.id).find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_exit_params
      params.require(:employee_exit).permit(:employee_id, :absence_type_id, :kind, :date, :left_at, :returned_at, :number_of_hours_absent, :cancel_url, :redirect_url)
    end
end
