class ReportReviewersController < ApplicationController
  before_action :set_report_reviewer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /report_reviewers
  def index
    @report_reviewers = ReportReviewer.all.includes(:employee)
    @report_reviewer = ReportReviewer.new
    @report_reviewer.cancel_and_redirect_url_to(report_reviewers_url)
    respond_to do |f|
      f.html
      f.json { render json: @report_reviewers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /report_reviewers/1
  def show
    @report_reviewer.cancel_and_redirect_url_to(report_reviewer_url(@report_reviewer))
    respond_to do |f|
      f.html
      f.json { render json: @report_reviewer.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /report_reviewers/new
  def new
    @report_reviewer = ReportReviewer.new
    @report_reviewer.cancel_url = report_reviewers_url
    respond_to do |f|
      f.html
      f.json { render json: @report_reviewer.as_json}
      f.js
    end
  end

  # GET /report_reviewers/1/edit
  def edit
    @report_reviewer.cancel_and_redirect_url_to(report_reviewer_url(@report_reviewer))
    respond_to do |f|
      f.html
      f.json { render json: @report_reviewer.as_json}
      f.js
    end
  end

  # POST /report_reviewers
  def create
    @report_reviewer = ReportReviewer.new(report_reviewer_params)
    respond_to do |f|
      if @report_reviewer.save
        f.html { redirect_to @report_reviewer.redirect_url || redirect_url || report_reviewer_url(@report_reviewer), notice: controller_t('.saved') }
        f.json { render json: @report_reviewer.as_json}
        f.js { render :index }
      else
        f.html { render :new }
        f.json { render json: @report_reviewer.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /report_reviewers/1
  def update
    respond_to do |f|
      if @report_reviewer.update(report_reviewer_params)
        f.html { redirect_to @report_reviewer.redirect_url || redirect_url || report_reviewer_url(@report_reviewer), notice: controller_t('.updated') }
        f.json { render json: @report_reviewer.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @report_reviewer.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /report_reviewers/1
  def destroy
    @report_reviewer.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || report_reviewers_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_reviewer
      @report_reviewer = ReportReviewer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_reviewer_params
      params.require(:report_reviewer).permit(:employee_id, :cancel_url, :redirect_url)
    end
end
