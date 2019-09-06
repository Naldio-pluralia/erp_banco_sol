class EmployeePresencesController < ApplicationController
  before_action :set_employee, only: [:confirm_employee_presence, :new_presence, :create_presence]
  before_action :set_employee_presence, only: [:show, :edit, :update, :destroy, :confirm_employee_presence]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_presences
  def index
    @employee_presences = EmployeePresence.all
    @employee_presence = EmployeePresence.new
    @employee_presence.cancel_and_redirect_url_to(employee_presences_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_presences.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_presences/1
  def show
    @employee_presence.cancel_and_redirect_url_to(employee_presence_url(@employee_presence))
    respond_to do |f|
      f.html
      f.json { render json: @employee_presence.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_presences/new
  def new
    @employee_presence = EmployeePresence.new
    @employee_presence.cancel_url = employee_presences_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_presence.as_json}
      f.js
    end
  end

  # GET /employee_presences/1/edit
  def edit
    @employee_presence.cancel_and_redirect_url_to(employee_presence_url(@employee_presence))
    respond_to do |f|
      f.html
      f.json { render json: @employee_presence.as_json}
      f.js
    end
  end

  # POST /employee_presences
  def create
    @employee_presence = EmployeePresence.new(employee_presence_params)
    respond_to do |f|
      if @employee_presence.save
        f.html { redirect_to @employee_presence.redirect_url || redirect_url || employee_presence_url(@employee_presence), notice: controller_t('.saved') }
        f.json { render json: @employee_presence.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_presence.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_presences/1
  def update
    respond_to do |f|
      if @employee_presence.update(employee_presence_params)
        f.html { redirect_to @employee_presence.redirect_url || redirect_url || employee_presence_url(@employee_presence), notice: controller_t('.updated') }
        f.json { render json: @employee_presence.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_presence.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_presences/1
  def destroy
    @employee_presence.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_presences_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def confirm_employee_presence
    respond_to do |f|
      if @employee_presence.update(status: :confirmed)
        f.html { render 'nextsgad/employees/presence' }
        f.json { render json: @employee_presence.as_json }
        f.js
      else
        f.html { render 'nextsgad/employees/presence', status: :unprocessable_entity}
        f.json { render json: @employee_presence.errors, status: :unprocessable_entity }
        f.js { render status: :unprocessable_entity }
      end
    end
  end

  def new_presence
    @employee_presence = EmployeePresence.new(employee_id: @employee.id)
    respond_to do |f|
      f.html
      f.json { render json: @employee_presence.as_json}
      f.js
    end
  end

  def create_presence
    @employee_presence = EmployeePresence.new(employee_presence_params)
    @employee_presence.employee_id = @employee.id
    @employee_presence.set_status
    respond_to do |f|
      if @employee_presence.save
        f.html { redirect_to @employee_presence.redirect_url, notice: controller_t('.saved') }
        f.json { render json: @employee_presence.as_json}
        f.js
      else
        f.html { render :new }
        f.json { render json: @employee_presence.errors, status: :unprocessable_entity }
        f.js{render :new_presence, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employee_presence
      @employee_presence = EmployeePresence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_presence_params
      params.require(:employee_presence).permit(:employee_id, :date, :status, :cancel_url, :redirect_url)
    end
end
