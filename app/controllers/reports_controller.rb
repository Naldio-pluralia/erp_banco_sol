class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :open_report, :cancel_report]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /reports
  def index
    @reports = Report.employee_id(params[:employee_id]).is_anonymous(params[:is_anonymous]).where.not(employee_id: current.employee&.id)
    @report = Report.new
    @report.cancel_and_redirect_url_to(reports_url)
    respond_to do |f|
      f.html
      f.json { render json: @reports.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /reports/1
  def show
    @report.cancel_and_redirect_url_to(report_url(@report))
    respond_to do |f|
      f.html
      f.json { render json: @report.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
    @report.cancel_url = reports_url
    respond_to do |f|
      f.html
      f.json { render json: @report.as_json}
      f.js
    end
  end

  # GET /reports/1/edit
  def edit
    @report.cancel_and_redirect_url_to(report_url(@report))
    respond_to do |f|
      f.html
      f.json { render json: @report.as_json}
      f.js
    end
  end

  # POST /reports
  def create
    @report = Report.new(report_params)
    @report.employee_id = current.employee&.id
    respond_to do |f|
      if @report.save
        f.html { redirect_to @report.redirect_url || redirect_url || report_url(@report), notice: controller_t('.saved') }
        f.json { render json: @report.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @report.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  def open_report
    @report.status_opened
    redirect_to report_url(@report), notice: controller_t('.updated')
  end

  def cancel_report
    @report.status_canceled
    redirect_to report_url(@report), notice: controller_t('.updated')
  end

  # PATCH/PUT /reports/1
  def update
    respond_to do |f|
      if @report.update(report_params)
        f.html { redirect_to @report.redirect_url || redirect_url || report_url(@report), notice: controller_t('.updated') }
        f.json { render json: @report.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @report.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || reports_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_params
      params.require(:report).permit(:employee_id, :name, :note, :is_anonymous, :cancel_url, :redirect_url)
    end
end
