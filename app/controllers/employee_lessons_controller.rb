class EmployeeLessonsController < ApplicationController
  before_action :set_employee_lesson, only: [:show, :edit, :update, :destroy, :watch]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_lessons
  def index
    @employee_lessons = EmployeeLesson.all
    @employee_lesson = EmployeeLesson.new
    @employee_lesson.cancel_and_redirect_url_to(employee_lessons_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_lessons.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_lessons/1
  def show
    @employee_lesson.cancel_and_redirect_url_to(employee_lesson_url(@employee_lesson))
    respond_to do |f|
      f.html
      f.json { render json: @employee_lesson.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_lessons/new
  def new
    @employee_lesson = EmployeeLesson.new
    @employee_lesson.cancel_url = employee_lessons_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_lesson.as_json}
      f.js
    end
  end

  # GET /employee_lessons/1/edit
  def edit
    @employee_lesson.cancel_and_redirect_url_to(employee_lesson_url(@employee_lesson))
    respond_to do |f|
      f.html
      f.json { render json: @employee_lesson.as_json}
      f.js
    end
  end

  # POST /employee_lessons
  def create
    @employee_lesson = EmployeeLesson.new(employee_lesson_params)
    respond_to do |f|
      if @employee_lesson.save
        f.html { redirect_to @employee_lesson.redirect_url || redirect_url || employee_lesson_url(@employee_lesson), notice: controller_t('.saved') }
        f.json { render json: @employee_lesson.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_lesson.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_lessons/1
  def update
    respond_to do |f|
      if @employee_lesson.update(employee_lesson_params)
        f.html { redirect_to @employee_lesson.redirect_url || redirect_url || employee_lesson_url(@employee_lesson), notice: controller_t('.updated') }
        f.json { render json: @employee_lesson.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_lesson.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_lessons/1
  def destroy
    @employee_lesson.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_lessons_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def watch
    @employee_lesson.done! if @employee_lesson.not_done?
    @employee_lesson.employee_chapter.employee_course.update_conclusion_percentage()
    respond_to do |f|
      f.html{redirect_to employee_course_url(@employee_lesson.employee_chapter.employee_course_id, employee_lesson_id: @employee_lesson.id)}
      f.json { render json: @employee_lesson.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_lesson
      @employee_lesson = EmployeeLesson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_lesson_params
      params.require(:employee_lesson).permit(:lesson_id, :employee_course_id, :cancel_url, :redirect_url)
    end
end
