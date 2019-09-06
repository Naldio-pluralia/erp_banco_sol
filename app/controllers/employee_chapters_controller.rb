class EmployeeChaptersController < ApplicationController
  before_action :set_employee_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_chapters
  def index
    @employee_chapters = EmployeeChapter.all
    @employee_chapter = EmployeeChapter.new
    @employee_chapter.cancel_and_redirect_url_to(employee_chapters_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_chapters.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_chapters/1
  def show
    @employee_chapter.cancel_and_redirect_url_to(employee_chapter_url(@employee_chapter))
    respond_to do |f|
      f.html
      f.json { render json: @employee_chapter.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_chapters/new
  def new
    @employee_chapter = EmployeeChapter.new
    @employee_chapter.cancel_url = employee_chapters_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_chapter.as_json}
      f.js
    end
  end

  # GET /employee_chapters/1/edit
  def edit
    @employee_chapter.cancel_and_redirect_url_to(employee_chapter_url(@employee_chapter))
    respond_to do |f|
      f.html
      f.json { render json: @employee_chapter.as_json}
      f.js
    end
  end

  # POST /employee_chapters
  def create
    @employee_chapter = EmployeeChapter.new(employee_chapter_params)
    respond_to do |f|
      if @employee_chapter.save
        f.html { redirect_to @employee_chapter.redirect_url || redirect_url || employee_chapter_url(@employee_chapter), notice: controller_t('.saved') }
        f.json { render json: @employee_chapter.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_chapter.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_chapters/1
  def update
    respond_to do |f|
      if @employee_chapter.update(employee_chapter_params)
        f.html { redirect_to @employee_chapter.redirect_url || redirect_url || employee_chapter_url(@employee_chapter), notice: controller_t('.updated') }
        f.json { render json: @employee_chapter.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_chapter.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_chapters/1
  def destroy
    @employee_chapter.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || employee_chapters_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_chapter
      @employee_chapter = EmployeeChapter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_chapter_params
      params.require(:employee_chapter).permit(:employee_course_id, :chapter_id, :status, :cancel_url, :redirect_url)
    end
end
