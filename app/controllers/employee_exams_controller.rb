class EmployeeExamsController < ApplicationController
  before_action :set_employee_exam, only: [:show, :edit, :update, :destroy, :complete]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_exams
  def index
    @employee_exams = EmployeeExam.all
    @employee_exam = EmployeeExam.new
    @employee_exam.cancel_and_redirect_url_to(employee_exams_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_exams.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_exams/1
  def show
    @employee_exam.cancel_and_redirect_url_to(employee_exam_url(@employee_exam))
    respond_to do |f|
      f.html
      f.json { render json: @employee_exam.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_exams/new
  def new
    @employee_exam = EmployeeExam.new
    @employee_exam.cancel_url = employee_exams_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_exam.as_json}
      f.js
    end
  end

  # GET /employee_exams/1/edit
  def edit
    @employee_exam.cancel_and_redirect_url_to(employee_exam_url(@employee_exam))
    respond_to do |f|
      f.html
      f.json { render json: @employee_exam.as_json}
      f.js
    end
  end

  # POST /employee_exams
  def create
    @employee_exam = EmployeeExam.new(employee_exam_params)
    respond_to do |f|
      if @employee_exam.save
        f.html { redirect_to @employee_exam.redirect_url || redirect_url || employee_exam_url(@employee_exam), notice: controller_t('.saved') }
        f.json { render json: @employee_exam.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_exam.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_exams/1
  def update
    respond_to do |f|
      if @employee_exam.update(employee_exam_params)
        f.html { redirect_to @employee_exam.redirect_url || redirect_url || employee_exam_url(@employee_exam), notice: controller_t('.updated') }
        f.json { render json: @employee_exam.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_exam.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_exams/1
  def destroy
    @employee_exam.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_exams_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def complete
    @employee_exam.done!
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_course_url(@employee_exam.employee_chapter.employee_course_id, employee_exam_id: @employee_exam.id), notice: 'Gravar' }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_exam
      @employee_exam = EmployeeExam.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_exam_params
      params.require(:employee_exam).permit(:exam_id, :employee_course_id, :cancel_url, :redirect_url)
    end
end
