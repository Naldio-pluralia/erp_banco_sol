class EmployeeJustificationsController < ApplicationController
  before_action :set_employee
  before_action :set_employee_justification, only: [:show, :edit, :update, :destroy, :add_answer]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_justifications
  def index
    @employee_justifications = EmployeeJustification.all
    @employee_justification = EmployeeJustification.new(employee_id: @employee.id)
    @employee_justification.cancel_and_redirect_url_to(employee_employee_justifications_url(@employee))
    respond_to do |f|
      f.html
      f.json { render json: @employee_justifications.as_json}
      f.js
      f.xls
      f.pdf
      f.text {render resolve_render, layout: false }
    end
  end

  # GET /employee_justifications/1
  def show
    @employee_justification.cancel_and_redirect_url_to(employee_employee_justification_url(@employee, @employee_justification))
    respond_to do |f|
      f.html
      f.json { render json: @employee_justification.as_json}
      f.js
      f.xls
      f.pdf
      f.text {render resolve_render, layout: false }
    end
  end

  # GET /employee_justifications/new
  def new
    @employee_justification = EmployeeJustification.new(employee_id: @employee.id)
    @employee_justification.cancel_url = employee_employee_justifications_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_justification.as_json}
      f.js
      f.text {render resolve_render, layout: false }
    end
  end

  # GET /employee_justifications/1/edit
  def edit
    @employee_justification.cancel_and_redirect_url_to(employee_employee_justification_url(@employee,@employee_justification))
    respond_to do |f|
      f.html
      f.json { render json: @employee_justification.as_json}
      f.js
      f.text {render resolve_render, layout: false }
    end
  end

  # POST /employee_justifications
  def create
    @employee_justification = EmployeeJustification.new(employee_justification_params)
    @employee_justification.employee_id = @employee.id
    respond_to do |f|
      if @employee_justification.save
        supervisor = @employee_justification&.employee&.efective_position&.position&.efective
        Notification.new_notification(@employee_justification.notification_justification_message, supervisor, employee_employee_justification_url(@employee, @employee_justification)) if supervisor.present?

        f.html { redirect_to @employee_justification.redirect_url || employee_employee_justification_url(@employee, @employee_justification), notice: controller_t('.saved') }
        f.json { render json: @employee_justification.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_justification.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_justifications/1
  def update
    respond_to do |f|
      if @employee_justification.update(employee_justification_params)
        f.html { redirect_to @employee_justification.redirect_url || employee_employee_justification_url(@employee, @employee_justification), notice: controller_t('.updated') }
        f.json { render json: @employee_justification.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_justification.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_justifications/1
  def destroy
    @employee_justification.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_employee_justifications_url(@employee), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def add_answer
    @justification_answer = JustificationAnswer.new(employee_id: current.employee&.id, employee_justification_id: @employee_justification.id, kind: params[:kind], status: params[:status])
    respond_to do |f|
      if @justification_answer.save
        f.html { redirect_to employee_employee_justification_url(@employee, @employee_justification), notice: controller_t('.updated') }
        f.json { render json: @justification_answer.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @justification_answer.errors, status: :unprocessable_entity }
        f.js { render :show }
      end
    end
  end

  def new_justification
    @employee_justification = EmployeeJustification.new(employee_id: @employee.id)
    @employee_justification.cancel_url = employee_employee_justifications_url(@employee)
    respond_to do |f|
      f.html
      f.json { render json: @employee_justification.as_json}
      f.js
      f.text {render resolve_render, layout: false }
    end
  end

  def create_justification
    @employee_justification = EmployeeJustification.new(employee_justification_params)
    @employee_justification.employee_id = @employee.id
    respond_to do |f|
      if @employee_justification.save
        # Notification.new_notification(@employee_justification.notification_justification_message, @employee_justification.employee, employee_employee_justification_url(@employee, @employee_justification))
        f.html { redirect_to @employee_justification.redirect_url || employee_employee_justification_url(@employee, @employee_justification), notice: controller_t('.saved') }
        f.json { render json: @employee_justification.as_json}
        f.js
      else
        f.html { render :new_employee_justification }
        f.json { render json: @employee_justification.errors, status: :unprocessable_entity }
        f.js { render :new_justification }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_justification
      @employee_justification = EmployeeJustification.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_justification_params
      params.require(:employee_justification).permit(:employee_id, :employee_note, :supervisor_note, :cancel_url, :redirect_url, :absence_object_id, {employee_absence_ids: [], employee_delay_ids: [], employee_exit_ids: [], attachments: []})
    end
end
