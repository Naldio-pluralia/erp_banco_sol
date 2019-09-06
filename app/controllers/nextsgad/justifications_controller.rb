module Nextsgad
  class JustificationsController < NextSgad::JustificationsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Justification
    before_action :set_justification, only: [:show, :edit, :update, :destroy, :aprove, :disaprove]

    # GET /justifications
    def index
      @justifications = Justification.all
      @justification = Justification.new
    end

    # GET /justifications/1
    def show
    end

    # GET /justifications/new
    def new
      @justification = Justification.new
    end

    # GET /justifications/1/edit
    def edit
    end

    # POST /justifications
    def create
      @justification = Justification.new(justification_params)

      if @justification.save
        # redirect_to employee_assessment_url(@justification.employee_id), notice: 'register_was_successfully_created'.ts
        redirect_to params[:redirect_url] || my_attendances_url, notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /justifications/1
    def update
      if @justification.update(justification_params)
        redirect_to @justification, notice: 'register_was_successfully_updated'.ts
      else
        render :edit
      end
    end

    # DELETE /justifications/1
    def destroy
      @justification.destroy
      redirect_to justifications_url, notice: 'register_was_successfully_destroyed'.ts
    end

    def aprove
      @justification.aprove
      redirect_to params[:redirect_url] || @justification, notice: 'register_was_successfully_updated'.ts
    end

    def disaprove
      @justification.disaprove
      redirect_to params[:redirect_url] || @justification, notice: 'register_was_successfully_updated'.ts
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_justification
      @justification = Justification.find(params[:id])
      @employee = @justification.employee
    end

    # Only allow a trusted parameter "white list" through.
    def justification_params
      params.require(:justification).permit(:documents, :position_id, :employee_id, :assessment_id, :dates, :status, :employee_note, :supervisor_note, :absence_object_id, {attendance_ids: [], documents: []})
    end
  end
end
