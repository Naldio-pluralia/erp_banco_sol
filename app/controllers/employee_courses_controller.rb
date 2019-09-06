class EmployeeCoursesController < ApplicationController
  before_action :set_employee_course, only: [:show, :edit, :update, :destroy, :complete]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout 'course_layout', only: :show

  # GET /employee_courses
  def index
    @employee_courses = EmployeeCourse.all
    @employee_course = EmployeeCourse.new
    @employee_course.cancel_and_redirect_url_to(employee_courses_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_courses.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_courses/1
  def show
    params[:employee_exam_id] = nil if params[:employee_lesson_id].present?
    @employee_course.cancel_and_redirect_url_to(employee_course_url(@employee_course)) 
    if params[:employee_exam_id].present?
      @employee_exam = @employee_course.employee_exams.find_by(id: params[:employee_exam_id])
    else
      @employee_lesson = @employee_course.employee_lessons.find_by(id: params[:employee_lesson_id]) ||  @employee_course.employee_lessons.first
    end
    respond_to do |f|
      f.html
      f.json { render json: @employee_course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_courses/new
  def new
    @employee_course = EmployeeCourse.new
    @employee_course.cancel_url = employee_courses_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_course.as_json}
      f.js
    end
  end

  # GET /employee_courses/1/edit
  def edit
    @employee_course.cancel_and_redirect_url_to(employee_course_url(@employee_course))
    respond_to do |f|
      f.html
      f.json { render json: @employee_course.as_json}
      f.js
    end
  end

  # POST /employee_courses
  def create
    @employee_course = EmployeeCourse.new(employee_course_params)
    respond_to do |f|
      if @employee_course.save
        f.html { redirect_to @employee_course.redirect_url || redirect_url || employee_course_url(@employee_course), notice: controller_t('.saved') }
        f.json { render json: @employee_course.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_course.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_courses/1
  def update
    respond_to do |f|
      if @employee_course.update(employee_course_params)
        f.html { redirect_to @employee_course.redirect_url || redirect_url || employee_course_url(@employee_course), notice: controller_t('.updated') }
        f.json { render json: @employee_course.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_course.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_courses/1
  def destroy
    @employee_course.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_courses_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def complete
    @employee_course.update(status: :done)
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_course_url}
      f.json { render json: @employee_course.as_json}
      f.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_course
      @employee_course = EmployeeCourse.includes(:employee_chapters, course: [:employee_courses, chapters: [:lessons, :exam]]).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_course_params
      params.require(:employee_course).permit(:employee_id, :course_id, :end, :status, :attempt_number, :cancel_url, :redirect_url)
    end
end
