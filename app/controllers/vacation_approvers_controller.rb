class VacationApproversController < ApplicationController
  before_action :set_vacation_approver, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /vacation_approvers
  def index
    @vacation_approvers = VacationApprover.all
    @vacation_approver = VacationApprover.new
    @vacation_approver.cancel_and_redirect_url_to(vacation_approvers_url)
    respond_to do |f|
      f.html
      f.json { render json: @vacation_approvers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /vacation_approvers/1
  def show
    @vacation_approver.cancel_and_redirect_url_to(vacation_approver_url(@vacation_approver))
    respond_to do |f|
      f.html
      f.json { render json: @vacation_approver.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /vacation_approvers/new
  def new
    @vacation_approver = VacationApprover.new
    @vacation_approver.cancel_url = vacation_approvers_url
    respond_to do |f|
      f.html
      f.json { render json: @vacation_approver.as_json}
      f.js
    end
  end

  # GET /vacation_approvers/1/edit
  def edit
    @vacation_approver.cancel_and_redirect_url_to(vacation_approver_url(@vacation_approver))
    respond_to do |f|
      f.html
      f.json { render json: @vacation_approver.as_json}
      f.js
    end
  end

  # POST /vacation_approvers
  def create
    @vacation_approver = VacationApprover.new(vacation_approver_params)
    respond_to do |f|
      if @vacation_approver.save
        f.html { redirect_to @vacation_approver.redirect_url || redirect_url || vacation_approver_url(@vacation_approver), notice: controller_t('.saved') }
        f.json { render json: @vacation_approver.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @vacation_approver.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /vacation_approvers/1
  def update
    respond_to do |f|
      if @vacation_approver.update(vacation_approver_params)
        f.html { redirect_to @vacation_approver.redirect_url || redirect_url || vacation_approver_url(@vacation_approver), notice: controller_t('.updated') }
        f.json { render json: @vacation_approver.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @vacation_approver.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /vacation_approvers/1
  def destroy
    @vacation_approver.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || vacation_approvers_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation_approver
      @vacation_approver = VacationApprover.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vacation_approver_params
      params.require(:vacation_approver).permit(:employee_id, :cancel_url, :redirect_url)
    end
end
