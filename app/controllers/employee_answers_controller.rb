class EmployeeAnswersController < ApplicationController
  before_action :set_employee_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_answers
  def index
    @employee_answers = EmployeeAnswer.all
    @employee_answer = EmployeeAnswer.new
    @employee_answer.cancel_and_redirect_url_to(employee_answers_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_answers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_answers/1
  def show
    @employee_answer.cancel_and_redirect_url_to(employee_answer_url(@employee_answer))
    respond_to do |f|
      f.html
      f.json { render json: @employee_answer.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_answers/new
  def new
    @employee_answer = EmployeeAnswer.new
    @employee_answer.cancel_url = employee_answers_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_answer.as_json}
      f.js
    end
  end

  # GET /employee_answers/1/edit
  def edit
    @employee_answer.cancel_and_redirect_url_to(employee_answer_url(@employee_answer))
    respond_to do |f|
      f.html
      f.json { render json: @employee_answer.as_json}
      f.js
    end
  end

  # POST /employee_answers
  def create
    @employee_answer = EmployeeAnswer.new(employee_answer_params)
    respond_to do |f|
      if @employee_answer.save
        f.html { redirect_to @employee_answer.redirect_url || redirect_url || employee_answer_url(@employee_answer), notice: controller_t('.saved') }
        f.json { render json: @employee_answer.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_answer.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_answers/1
  def update
    respond_to do |f|
      if @employee_answer.update(employee_answer_params)
        @employee_answer.employee_question.update(status: :done) if @employee_answer.employee_question.not_done?
        # @employee_answer.employee_question.employee_exam.update_status()
        # @employee_answer.employee_question.employee_exam.employee_chapter.employee_course.update_conclusion_percentage()
        f.html { redirect_to @employee_answer.redirect_url || redirect_url || employee_course_url(@employee_answer.employee_question.employee_exam.employee_chapter.employee_course, employee_exam_id: @employee_answer.employee_question.employee_exam.id), notice: controller_t('.updated') }
        f.json { render json: @employee_answer.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_answer.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_answers/1
  def destroy
    @employee_answer.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_answers_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_answer
      @employee_answer = EmployeeAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_answer_params
      params.require(:employee_answer).permit(:question_id, :answer, :option, :employee_course_id, :cancel_url, :redirect_url)
    end
end
