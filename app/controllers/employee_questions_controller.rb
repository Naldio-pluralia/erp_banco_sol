class EmployeeQuestionsController < ApplicationController
  before_action :set_employee_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_questions
  def index
    @employee_questions = EmployeeQuestion.all
    @employee_question = EmployeeQuestion.new
    @employee_question.cancel_and_redirect_url_to(employee_questions_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_questions.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_questions/1
  def show
    @employee_question.cancel_and_redirect_url_to(employee_question_url(@employee_question))
    respond_to do |f|
      f.html
      f.json { render json: @employee_question.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_questions/new
  def new
    @employee_question = EmployeeQuestion.new
    @employee_question.cancel_url = employee_questions_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_question.as_json}
      f.js
    end
  end

  # GET /employee_questions/1/edit
  def edit
    @employee_question.cancel_and_redirect_url_to(employee_question_url(@employee_question))
    respond_to do |f|
      f.html
      f.json { render json: @employee_question.as_json}
      f.js
    end
  end

  # POST /employee_questions
  def create
    @employee_question = EmployeeQuestion.new(employee_question_params)
    respond_to do |f|
      if @employee_question.save
        f.html { redirect_to @employee_question.redirect_url || redirect_url || employee_question_url(@employee_question), notice: controller_t('.saved') }
        f.json { render json: @employee_question.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_question.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_questions/1
  def update
    respond_to do |f|
      if @employee_question.update(employee_question_params)
        f.html { redirect_to @employee_question.redirect_url || redirect_url || employee_question_url(@employee_question), notice: controller_t('.updated') }
        f.json { render json: @employee_question.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_question.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_questions/1
  def destroy
    @employee_question.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_questions_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_question
      @employee_question = EmployeeQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_question_params
      params.require(:employee_question).permit(:employee_course_id, :employee_exam_id, :question_id, :status, :cancel_url, :redirect_url)
    end
end
