class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /exams
  def index
    @exams = Exam.all
    @exam = Exam.new
    @exam.cancel_and_redirect_url_to(exams_url)
    respond_to do |f|
      f.html
      f.json { render json: @exams.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /exams/1
  def show
    @exam.cancel_and_redirect_url_to(exam_url(@exam))
    respond_to do |f|
      f.html
      f.json { render json: @exam.as_json}
      f.js{render resolve_render}
      f.xls
      f.pdf
    end
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @exam.chapter_id = params[:chapter_id] if params[:chapter_id].present?
    @exam.cancel_url = exams_url
    respond_to do |f|
      f.html
      f.json { render json: @exam.as_json}
      f.js{render resolve_render }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam.cancel_and_redirect_url_to(exam_url(@exam))
    respond_to do |f|
      f.html
      f.json { render json: @exam.as_json}
      f.js
    end
  end

  # POST /exams
  def create
    @exam = Exam.new(exam_params)
    respond_to do |f|
      if @exam.save
        f.html { redirect_to @exam.redirect_url || redirect_url || exam_url(@exam), notice: controller_t('.saved') }
        f.json { render json: @exam.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @exam.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /exams/1
  def update
    respond_to do |f|
      if @exam.update(exam_params)
        f.html { redirect_to @exam.redirect_url || redirect_url || exam_url(@exam), notice: controller_t('.updated') }
        f.json { render json: @exam.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @exam.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /exams/1
  def destroy
    @exam.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || exams_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def exam_params
      params.require(:exam).permit(:chapter_id, :expected_value, :cancel_url, :redirect_url)
    end
end
