class EmployeeRequestsController < ApplicationController
  before_action :set_employee_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_requests
  def index
    @employee_requests = EmployeeRequest.where.not(employee_id: current.employee&.id)
    @employee_request = EmployeeRequest.new
    @employee_request.cancel_and_redirect_url_to(employee_requests_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_requests.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_requests/1
  def show
    @employee_request.cancel_and_redirect_url_to(employee_request_url(@employee_request))
    @employee_request.cancel_url = employee_request_url(@employee_request)
    respond_to do |f|
      f.html
      f.json { render json: @employee_request.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_requests/new
  def new
    @employee_request = EmployeeRequest.new
    @employee_request.cancel_url = employee_requests_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_request.as_json}
      f.js
    end
  end

  # GET /employee_requests/1/edit
  def edit
    @employee_request.cancel_and_redirect_url_to(employee_request_url(@employee_request))
    respond_to do |f|
      f.html
      f.json { render json: @employee_request.as_json}
      f.js
    end
  end

  # POST /employee_requests
  def create
    @employee_request = EmployeeRequest.new(employee_request_params)
    @employee_request.employee_id = current.employee&.id
    respond_to do |f|
      if @employee_request.save
        data = @employee_request.virtual_object_attachments.map{|f| {file: f, object_id: @employee_request.id, object_type: @employee_request.class.name, description: f.filename}}
        @employee_request.object_attachments.create(data)
        @employee_request.remove_virtual_object_attachments!
        # TODO Verificar um jeito de remover os anexos na coluna temporario
        f.html { redirect_to @employee_request.redirect_url || redirect_url || employee_request_url(@employee_request), notice: controller_t('.saved') }
        f.json { render json: @employee_request.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_request.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_requests/1
  def update
    respond_to do |f|
      if @employee_request.update(employee_request_params)
        f.html { redirect_to @employee_request.redirect_url || redirect_url || employee_request_url(@employee_request), notice: controller_t('.updated') }
        f.json { render json: @employee_request.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_request.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_requests/1
  def destroy
    @employee_request.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_requests_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_request
      @employee_request = EmployeeRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_request_params
      params.require(:employee_request).permit(:employee_id, :name, :note, :request_type_id, :cancel_url, :redirect_url, {virtual_object_attachments: [], virtual_object_attachments_cache: [], virtual_object_attachments_small: []})
    end
end
