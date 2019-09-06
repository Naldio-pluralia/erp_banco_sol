class AbsenceTypesController < ApplicationController
  before_action :set_absence_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /absence_types
  def index
    @absence_types = AbsenceType.latests
    @absence_type = AbsenceType.new
    # @absence_type.approvers.build
    #@absence_type.cancel_and_redirect_url_to(absence_types_url)
    respond_to do |f|
      f.html
      f.json { render json: @absence_types.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /absence_types/1
  def show
    @absence_type.cancel_and_redirect_url_to(absence_type_url(@absence_type))
    respond_to do |f|
      f.html
      f.json { render json: @absence_type.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /absence_types/new
  def new
    @absence_type = AbsenceType.new
    @absence_type.cancel_url = absence_types_url
    respond_to do |f|
      f.html
      f.json { render json: @absence_type.as_json}
      f.js
    end
  end

  # GET /absence_types/1/edit
  def edit
    @absence_type.cancel_and_redirect_url_to(absence_type_url(@absence_type))
    respond_to do |f|
      f.html
      f.json { render json: @absence_type.as_json}
      f.js
    end
  end

  # POST /absence_types
  def create
    @absence_type = AbsenceType.new(absence_type_params)
    respond_to do |f|
      if @absence_type.save
        f.html { redirect_to @absence_type.redirect_url || absence_type_url(@absence_type), notice: controller_t('.saved') }
        f.json { render json: @absence_type.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @absence_type.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /absence_types/1
  def update
    @absence_type = AbsenceType.new(absence_type_params)
    respond_to do |f|
      if @absence_type.save
        f.html { redirect_to absence_type_url(@absence_type), notice: controller_t('.updated') }
        f.json { render json: @absence_type.as_json}
        f.js { render :show }
      else
        p @absence_type.errors.messages
        f.html { render :edit }
        f.json { render json: @absence_type.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /absence_types/1
  def destroy
    @absence_type.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || absence_types_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absence_type
      @absence_type = AbsenceType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def absence_type_params
      params.require(:absence_type).permit(:name, :description, :kind, :code, :is_system_absence, :requires_document, :requires_justification, :requires_supervisor_justification, :requires_approver_justification, :requires_approver_supervisor_justification, :cancel_url, :redirect_url, approvers_attributes: [:employee_id, :kind])
    end
end
