class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :create_exam]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /chapters
  def index
    @chapters = Chapter.all
    @chapter = Chapter.new
    @chapter.cancel_and_redirect_url_to(chapters_url)
    respond_to do |f|
      f.html
      f.json { render json: @chapters.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /chapters/1
  def show
    @chapter.cancel_and_redirect_url_to(chapter_url(@chapter))
    respond_to do |f|
      f.html
      f.json { render json: @chapter.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @chapter.cancel_url = chapters_url
    respond_to do |f|
      f.html
      f.json { render json: @chapter.as_json}
      f.js
    end
  end

  # GET /chapters/1/edit
  def edit
    @chapter.cancel_and_redirect_url_to(chapter_url(@chapter))
    respond_to do |f|
      f.html
      f.json { render json: @chapter.as_json}
      f.js
    end
  end

  # POST /chapters
  def create
    @chapter = Chapter.new(chapter_params)
    respond_to do |f|
      if @chapter.save
        f.html { redirect_to @chapter.redirect_url || redirect_url || chapter_url(@chapter), notice: controller_t('.saved') }
        f.json { render json: @chapter.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @chapter.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /chapters/1
  def update
    respond_to do |f|
      if @chapter.update(chapter_params)
        f.html { redirect_to @chapter.redirect_url || redirect_url || chapter_url(@chapter), notice: controller_t('.updated') }
        f.json { render json: @chapter.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @chapter.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /chapters/1
  def destroy
    @chapter.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || chapters_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end


  def create_exam
    exam = Exam.create(chapter_id: @chapter.id) 
    respond_to do |f|
      f.html { redirect_to course_url(@chapter.course, exam_id: exam.id), notice: "Exame Criado"}
      f.json { render json: @chapter.as_json}
      f.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chapter_params
      params.require(:chapter).permit(:number, :name, :course_id, :cancel_url, :redirect_url)
    end
end
