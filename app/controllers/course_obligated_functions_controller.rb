class CourseObligatedFunctionsController < ApplicationController
  before_action :set_course_obligated_function, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /course_obligated_functions
  def index
    @course_obligated_functions = CourseObligatedFunction.all
    @course_obligated_function = CourseObligatedFunction.new
    @course_obligated_function.cancel_and_redirect_url_to(course_obligated_functions_url)
    respond_to do |f|
      f.html
      f.json { render json: @course_obligated_functions.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /course_obligated_functions/1
  def show
    @course_obligated_function.cancel_and_redirect_url_to(course_obligated_function_url(@course_obligated_function))
    respond_to do |f|
      f.html
      f.json { render json: @course_obligated_function.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /course_obligated_functions/new
  def new
    @course_obligated_function = CourseObligatedFunction.new
    @course_obligated_function.cancel_url = course_obligated_functions_url
    respond_to do |f|
      f.html
      f.json { render json: @course_obligated_function.as_json}
      f.js
    end
  end

  # GET /course_obligated_functions/1/edit
  def edit
    @course_obligated_function.cancel_and_redirect_url_to(course_obligated_function_url(@course_obligated_function))
    respond_to do |f|
      f.html
      f.json { render json: @course_obligated_function.as_json}
      f.js
    end
  end

  # POST /course_obligated_functions
  def create
    @course_obligated_function = CourseObligatedFunction.new(course_obligated_function_params)
    respond_to do |f|
      if @course_obligated_function.save
        f.html { redirect_to @course_obligated_function.redirect_url || redirect_url || course_obligated_function_url(@course_obligated_function), notice: controller_t('.saved') }
        f.json { render json: @course_obligated_function.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @course_obligated_function.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /course_obligated_functions/1
  def update
    respond_to do |f|
      if @course_obligated_function.update(course_obligated_function_params)
        f.html { redirect_to @course_obligated_function.redirect_url || redirect_url || course_obligated_function_url(@course_obligated_function), notice: controller_t('.updated') }
        f.json { render json: @course_obligated_function.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @course_obligated_function.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /course_obligated_functions/1
  def destroy
    @course_obligated_function.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || course_obligated_functions_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_obligated_function
      @course_obligated_function = CourseObligatedFunction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_obligated_function_params
      params.require(:course_obligated_function).permit(:course_id, :function_id, :cancel_url, :redirect_url)
    end
end
