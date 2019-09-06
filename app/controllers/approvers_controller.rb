class ApproversController < ApplicationController
  before_action :set_absence_type
  before_action :set_approver, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource :absence_type
  load_and_authorize_resource :approver, through: :absence_type
  layout :resolve_layout

  # GET /approvers
  def index
    @approvers = Approver.all
    @approver = Approver.new(absence_type_id: @absence_type.id)
    @approver.cancel_and_redirect_url_to(absence_type_approvers_url(@absence_type))
    respond_to do |f|
      f.html
      f.json { render json: @approvers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /approvers/1
  def show
    @approver.cancel_and_redirect_url_to(absence_type_approver_url(@absence_type, @approver))
    respond_to do |f|
      f.html
      f.json { render json: @approver.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /approvers/new
  def new
    @approver = Approver.new(absence_type_id: @absence_type.id)
    @approver.cancel_url = absence_type_approvers_url(@absence_type)
    respond_to do |f|
      f.html
      f.json { render json: @approver.as_json}
      f.js
    end
  end

  # GET /approvers/1/edit
  def edit
    @approver.cancel_and_redirect_url_to(absence_type_approver_url(@absence_type, @approver))
    respond_to do |f|
      f.html
      f.json { render json: @approver.as_json}
      f.js
    end
  end

  # POST /approvers
  def create
    @approver = Approver.new(approver_params)
    @approver.absence_type_id = @absence_type.id
    respond_to do |f|
      if @approver.save
        f.html { redirect_to @approver.redirect_url || absence_type_url(@absence_type), notice: controller_t('.saved') }
        f.json { render json: @approver.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @approver.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /approvers/1
  def update
    respond_to do |f|
      if @approver.update(approver_params)
        f.html { redirect_to @approver.redirect_url || absence_type_approver_url(@absence_type, @approver), notice: controller_t('.updated') }
        f.json { render json: @approver.as_json}
        f.js { render :show }
      else
        p @approver.errors.messages
        f.html { render :edit }
        f.json { render json: @approver.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /approvers/1
  def destroy
    @approver.destroy
    
    respond_to do |f|
      f.html { redirect_to absence_type_url(@absence_type), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_approver
      @approver = @absence_type.approvers.find(params[:id])
    end

    def set_absence_type
      @absence_type = AbsenceType.find(params[:absence_type_id])
    end

    # Only allow a trusted parameter "white list" through.
    def approver_params
      params.require(:approver).permit(:employee_id, :kind, :absence_type_id, :cancel_url, :redirect_url)
    end
end
