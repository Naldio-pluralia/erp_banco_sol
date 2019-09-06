class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :file_upload]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout
  skip_before_action :verify_authenticity_token, only: [:update]

  # GET /lessons
  def index
    @lessons = Lesson.all
    @lesson = Lesson.new
    @lesson.cancel_and_redirect_url_to(lessons_url)
    respond_to do |f|
      f.html
      f.json { render json: @lessons.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /lessons/1
  def show
    @lesson.cancel_and_redirect_url_to(lesson_url(@lesson))
    respond_to do |f|
      f.html
      f.json { render json: @lesson.as_json}
      f.js {render resolve_render }
      f.xls
      f.pdf
    end
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @lesson.chapter_id = params[:chapter_id] if params[:chapter_id].present?
    @lesson.cancel_url = lessons_url
    respond_to do |f|
      f.html
      f.json { render json: @lesson.as_json}
      f.js{render resolve_render }
      f.text {render resolve_render, layout: false }
    end
  end

  # GET /lessons/1/edit
  def edit
    @lesson.cancel_and_redirect_url_to(lesson_url(@lesson))
    respond_to do |f|
      f.html
      f.json { render json: @lesson.as_json}
      f.js{render resolve_render }
      f.text {render resolve_render, layout: false }
    end
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)
    respond_to do |f|
      if @lesson.save
        f.html { redirect_to @lesson.redirect_url || redirect_url || lesson_url(@lesson), notice: controller_t('.saved') }
        f.json { render json: @lesson.as_json}
        f.js { render  @lesson.render_view || :recorded }
      else
        f.html { render :new }
        f.json { render json: @lesson.errors, status: :unprocessable_entity }
        f.js { render  @lesson.render_view || :new }
      end
    end
  end

  # PATCH/PUT /lessons/1
  def update
    respond_to do |f|
      @lesson.update(lesson_params)
      @lesson.errors.delete(:local_video) if params[:lesson][:local_video].blank?
      if !@lesson.errors.any?
        f.html
        f.json { render json: @lesson.as_json}
        f.js { render  @lesson.render_view || :recorded }
      else
        f.html { render :edit }
        f.json { render json: @lesson.errors, status: :unprocessable_entity }
        f.js { render  @lesson.render_view || :new }
      end
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || @lesson.course, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def file_upload
    respond_to do |f|
      if @lesson.update(local_video: params[lesson_file_upload_url(@lesson.id)])
        f.html
        f.json { render json: @lesson.as_json}
        f.js { render  @lesson.render_view || :recorded }
      else
        f.html { render :edit }
        f.json { render json: @lesson.errors, status: :unprocessable_entity }
        f.js { render  @lesson.render_view || :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lesson_params
      params.require(:lesson).permit(:name, :video, :text, :chapter_id, :number, :video_kind, :cancel_url, :redirect_url)
    end
end
