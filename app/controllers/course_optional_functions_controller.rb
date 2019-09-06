class CourseOptionalFunctionsController < ApplicationController
  before_action :set_course_optional_function, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /course_optional_functions
  def index
    @course_optional_functions = CourseOptionalFunction.all
    @course_optional_function = CourseOptionalFunction.new
    @course_optional_function.cancel_and_redirect_url_to(course_optional_functions_url)
    respond_to do |f|
      f.html
      f.json { render json: @course_optional_functions.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /course_optional_functions/1
  def show
    @course_optional_function.cancel_and_redirect_url_to(course_optional_function_url(@course_optional_function))
    respond_to do |f|
      f.html
      f.json { render json: @course_optional_function.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /course_optional_functions/new
  def new
    @course_optional_function = CourseOptionalFunction.new
    @course_optional_function.cancel_url = course_optional_functions_url
    respond_to do |f|
      f.html
      f.json { render json: @course_optional_function.as_json}
      f.js
    end
  end

  # GET /course_optional_functions/1/edit
  def edit
    @course_optional_function.cancel_and_redirect_url_to(course_optional_function_url(@course_optional_function))
    respond_to do |f|
      f.html
      f.json { render json: @course_optional_function.as_json}
      f.js
    end
  end

  # POST /course_optional_functions
  def create
    @course_optional_function = CourseOptionalFunction.new(course_optional_function_params)
    respond_to do |f|
      if @course_optional_function.save
        f.html { redirect_to @course_optional_function.redirect_url || redirect_url || course_optional_function_url(@course_optional_function), notice: controller_t('.saved') }
        f.json { render json: @course_optional_function.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @course_optional_function.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /course_optional_functions/1
  def update
    respond_to do |f|
      if @course_optional_function.update(course_optional_function_params)
        f.html { redirect_to @course_optional_function.redirect_url || redirect_url || course_optional_function_url(@course_optional_function), notice: controller_t('.updated') }
        f.json { render json: @course_optional_function.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @course_optional_function.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /course_optional_functions/1
  def destroy
    @course_optional_function.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || course_optional_functions_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_optional_function
      @course_optional_function = CourseOptionalFunction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_optional_function_params
      params.require(:course_optional_function).permit(:course_id, :function_id, :cancel_url, :redirect_url)
    end
end
