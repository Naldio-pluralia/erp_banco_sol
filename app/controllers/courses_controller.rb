class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :start, :continue, :remake, :open, :close, :draft, :statistics, :see]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /courses
  def index
    @courses = Course.all.includes(:employee_courses)
    @course = Course.new
    @course.cancel_and_redirect_url_to(courses_url)
    respond_to do |f|
      f.html
      f.json { render json: @courses.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /courses/1
  def show
    @chapter = Chapter.new(course_id: @course.id, cancel_url: course_url(@course), redirect_url: course_url(@course))

    @course.cancel_and_redirect_url_to(course_url(@course))
    respond_to do |f|
      f.html{render resolve_render, layout: true}
      f.json { render json: @course.as_json}
      f.js
      f.xls
      f.pdf
      f.text {render 'show.html.erb', layout: false, status: :ok}
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    @course.cancel_url = courses_url
    respond_to do |f|
      f.html
      f.json { render json: @course.as_json}
      f.js
    end
  end

  # GET /courses/1/edit
  def edit
    @course.cancel_and_redirect_url_to(course_url(@course))
    respond_to do |f|
      f.html
      f.json { render json: @course.as_json}
      f.js
    end
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    respond_to do |f|
      if @course.save
        f.html { redirect_to @course.redirect_url || redirect_url || course_url(@course), notice: controller_t('.saved') }
        f.json { render json: @course.as_json}
        f.js { render :show }
      else
        p @course.errors.messages
        f.html { render :new }
        f.json { render json: @course.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /courses/1
  def update
    respond_to do |f|
      if @course.update(course_params)
        f.html { redirect_to @course.redirect_url || redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @course.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || courses_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def report_courses
    @courses = Course.all.includes(:employee_courses).accessible_to(current.employee)
    respond_to do |f|
      f.html
      f.json { render json: @courses.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def open
    respond_to do |f|
      if @course.opened!
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.as_json}
        f.js { render :show }
      else
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.errors, status: :unprocessable_entity }
        f.js { resolve_render }
      end
    end
  end

  def close
    respond_to do |f|
      if @course.closed!
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.as_json}
        f.js { render :show }
      else
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.errors, status: :unprocessable_entity }
        f.js { resolve_render }
      end
    end
  end

  def draft
    respond_to do |f|
      if @course.draft!
        @course.employee_courses.each(&:destroy)
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.as_json}
        f.js { render :show }
      else
        f.html { redirect_to redirect_url || course_url(@course), notice: controller_t('.updated') }
        f.json { render json: @course.errors, status: :unprocessable_entity }
        f.js { resolve_render }
      end
    end
  end

  def start
    @employee_course = EmployeeCourse.create(employee_id: current.employee&.id, course_id: @course.id)
    @employee_course.start_course
    respond_to do |f|
      f.html{redirect_to @employee_course}
      f.json { render json: @employee_course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def continue
    @employee_course = @course.employee_courses.in_progress.where(employee_id: current.employee&.id).order(attempt_number: :asc).last
    respond_to do |f|
      f.html{redirect_to @employee_course}
      f.json { render json: @employee_course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def restart
    @employee_course = EmployeeCourse.create(employee_id: current.employee&.id, course_id: @course.id)
    @employee_course.start_course
    respond_to do |f|
      f.html{redirect_to @employee_course}
      f.json { render json: @employee_course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def my_training
    @courses = Course.opened.accessible_to(current.employee).includes(:employee_courses)
    respond_to do |f|
      f.html{ render resolve_render(:index) }
      f.json { render json: @courses.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def statistics
    respond_to do |f|
      f.html{render resolve_render, layout: true}
      f.json { render json: @course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def see
    @employee_course = @course.employee_courses.done.where(employee_id: current.employee&.id).order(attempt_number: :asc).last
    respond_to do |f|
      f.html{redirect_to @employee_course}
      f.json { render json: @employee_course.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.includes(:employee_courses, chapters: [:lessons, :exam]).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:name, :status, :approval_amount, :description, :for_all, :cancel_url, :redirect_url, {obligated_function_ids: [], optional_function_ids: []})
    end
end
