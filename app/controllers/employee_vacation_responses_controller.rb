class EmployeeVacationResponsesController < ApplicationController
  before_action :set_employee_vacation_response, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_vacation_responses
  def index
    @employee_vacation_responses = EmployeeVacationResponse.all
    @employee_vacation_response = EmployeeVacationResponse.new
    @employee_vacation_response.cancel_and_redirect_url_to(employee_vacation_responses_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation_responses.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_vacation_responses/1
  def show
    @employee_vacation_response.cancel_and_redirect_url_to(employee_vacation_response_url(@employee_vacation_response))
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation_response.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_vacation_responses/new
  def new
    @employee_vacation_response = EmployeeVacationResponse.new
    @employee_vacation_response.cancel_url = employee_vacation_responses_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation_response.as_json}
      f.js
    end
  end

  # GET /employee_vacation_responses/1/edit
  def edit
    @employee_vacation_response.cancel_and_redirect_url_to(employee_vacation_response_url(@employee_vacation_response))
    respond_to do |f|
      f.html
      f.json { render json: @employee_vacation_response.as_json}
      f.js
    end
  end

  # POST /employee_vacation_responses
  def create
    @employee_vacation_response = EmployeeVacationResponse.new(employee_vacation_response_params)
    respond_to do |f|
      if @employee_vacation_response.save
        f.html { redirect_to @employee_vacation_response.redirect_url || redirect_url || employee_vacation_response_url(@employee_vacation_response), notice: controller_t('.saved') }
        f.json { render json: @employee_vacation_response.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_vacation_response.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_vacation_responses/1
  def update
    @employee_vacation_response.employee_id = current.employee&.id
    respond_to do |f|
      if @employee_vacation_response.update(employee_vacation_response_params)
        f.html { redirect_to @employee_vacation_response.redirect_url || redirect_url || employee_vacation_response_url(@employee_vacation_response), notice: controller_t('.updated') }
        f.json { render json: @employee_vacation_response.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_vacation_response.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_vacation_responses/1
  def destroy
    @employee_vacation_response.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_vacation_responses_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_vacation_response
      @employee_vacation_response = EmployeeVacationResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_vacation_response_params
      params.require(:employee_vacation_response).permit(:employee_vacation_id, :employee_id, :status, :kind, :cancel_url, :redirect_url)
    end
end
