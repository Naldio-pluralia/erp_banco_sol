class EmployeeQuestionOptionsController < ApplicationController
  before_action :set_employee_question_option, only: [:show, :edit, :update, :destroy, :select]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_question_options
  def index
    @employee_question_options = EmployeeQuestionOption.all
    @employee_question_option = EmployeeQuestionOption.new
    @employee_question_option.cancel_and_redirect_url_to(employee_question_options_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_question_options.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_question_options/1
  def show
    @employee_question_option.cancel_and_redirect_url_to(employee_question_option_url(@employee_question_option))
    respond_to do |f|
      f.html
      f.json { render json: @employee_question_option.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_question_options/new
  def new
    @employee_question_option = EmployeeQuestionOption.new
    @employee_question_option.cancel_url = employee_question_options_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_question_option.as_json}
      f.js
    end
  end

  # GET /employee_question_options/1/edit
  def edit
    @employee_question_option.cancel_and_redirect_url_to(employee_question_option_url(@employee_question_option))
    respond_to do |f|
      f.html
      f.json { render json: @employee_question_option.as_json}
      f.js
    end
  end

  # POST /employee_question_options
  def create
    @employee_question_option = EmployeeQuestionOption.new(employee_question_option_params)
    respond_to do |f|
      if @employee_question_option.save
        f.html { redirect_to @employee_question_option.redirect_url || redirect_url || employee_question_option_url(@employee_question_option), notice: controller_t('.saved') }
        f.json { render json: @employee_question_option.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_question_option.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_question_options/1
  def update
    respond_to do |f|
      if @employee_question_option.update(employee_question_option_params)
        f.html { redirect_to @employee_question_option.redirect_url || redirect_url || employee_question_option_url(@employee_question_option), notice: controller_t('.updated') }
        f.json { render json: @employee_question_option.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_question_option.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_question_options/1
  def destroy
    @employee_question_option.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_question_options_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def select
    @employee_question_option.update(is_selected: !@employee_question_option.is_selected)
    question = @employee_question_option.employee_question.question
    if (question.boolean_question? || question.single_choice?) && @employee_question_option.is_selected
      @employee_question_option.employee_question.employee_question_options.where.not(id: @employee_question_option.id).update_all(is_selected: false)
    end
    @employee_question_option.employee_question.update(status: :done) if @employee_question_option.employee_question.not_done?
    # @employee_question_option.employee_question.employee_exam.update_status()
    # @employee_question_option.employee_question.employee_exam.employee_chapter.employee_course.update_conclusion_percentage()
    respond_to do |f|
      f.html{redirect_to employee_course_url(@employee_question_option.employee_question.employee_exam.employee_chapter.employee_course, employee_exam_id: @employee_question_option.employee_question.employee_exam.id)}
      f.json { render json: @employee_question_option.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_question_option
      @employee_question_option = EmployeeQuestionOption.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_question_option_params
      params.require(:employee_question_option).permit(:question_option_id, :employee_course_id, :cancel_url, :redirect_url)
    end
end
