class JustificationAnswersController < ApplicationController
  before_action :set_justification_answer, only: [:show, :edit, :update, :destroy, :approved]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /justification_answers
  def index
    @justification_answers = JustificationAnswer.all
    @justification_answer = JustificationAnswer.new()
    @justification_answer.cancel_and_redirect_url_to(justification_answers_url(@employee, @employee_justification))
    respond_to do |f|
      f.html
      f.json { render json: @justification_answers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /justification_answers/1
  def show
    @justification_answer.cancel_and_redirect_url_to(justification_answer_url(@justification_answer))
    respond_to do |f|
      f.html
      f.json { render json: @justification_answer.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /justification_answers/new
  def new
    @justification_answer = JustificationAnswer.new()
    @justification_answer.cancel_url = justification_answers_url(@employee, @employee_justification)
    respond_to do |f|
      f.html
      f.json { render json: @justification_answer.as_json}
      f.js
    end
  end

  # GET /justification_answers/1/edit
  def edit
    @justification_answer.cancel_and_redirect_url_to(justification_answer_url(@justification_answer))
    respond_to do |f|
      f.html
      f.json { render json: @justification_answer.as_json}
      f.js
    end
  end

  # POST /justification_answers
  def create
    @justification_answer = JustificationAnswer.new(justification_answer_params)
    @justification_answer.employee_justification_id = @employee_justification.id
    respond_to do |f|
      if @justification_answer.save
        f.html { redirect_to @justification_answer.redirect_url || justification_answer_url(@justification_answer), notice: controller_t('.saved') }
        f.json { render json: @justification_answer.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @justification_answer.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /justification_answers/1
  def update
    respond_to do |f|
      if @justification_answer.update(justification_answer_params)
        Notification.new_notification(@justification_answer.notification_justification_answer_message, @justification_answer&.employee_justification&.employee, '/#')
        f.html { redirect_to @justification_answer.redirect_url || justification_answer_url(@justification_answer), notice: controller_t('.updated') }
        f.json { render json: @justification_answer.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @justification_answer.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /justification_answers/1
  def destroy
    @justification_answer.destroy

    respond_to do |f|
      f.html { redirect_to justification_answers_url(@employee, @employee_justification), notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def approved

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_justification_answer
      @justification_answer = JustificationAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def justification_answer_params
      params.require(:justification_answer).permit(:employee_justification_id, :employee_id, :status, :kind, :cancel_url, :redirect_url)
    end
end
