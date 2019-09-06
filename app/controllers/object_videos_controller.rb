class ObjectVideosController < ApplicationController
  before_action :set_object_video, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout
  skip_before_action :verify_authenticity_token, only: [:update, :create, :edit, :new]

  # GET /object_videos
  def index
    @object_videos = ObjectVideo.all
    @object_video = ObjectVideo.new
    @object_video.cancel_and_redirect_url_to(object_videos_url)
    respond_to do |f|
      f.html
      f.json { render json: @object_videos.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_videos/1
  def show
    @object_video.cancel_and_redirect_url_to(object_video_url(@object_video))
    respond_to do |f|
      f.html
      f.json { render json: @object_video.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_videos/new
  def new
    @object_video = ObjectVideo.new
    @object_video.cancel_url = object_videos_url
    respond_to do |f|
      f.html
      f.json { render json: @object_video.as_json}
      f.js
    end
  end

  # GET /object_videos/1/edit
  def edit
    @object_video.cancel_and_redirect_url_to(object_video_url(@object_video))
    respond_to do |f|
      f.html
      f.json { render json: @object_video.as_json}
      f.js
    end
  end

  # POST /object_videos
  def create
    @object_video = ObjectVideo.new(object_video_params)
    respond_to do |f|
      if @object_video.save
        f.html { redirect_to @object_video.redirect_url || redirect_url || object_video_url(@object_video), notice: controller_t('.saved') }
        f.json { render json: @object_video.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @object_video.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /object_videos/1
  def update
    respond_to do |f|
      if @object_video.update(object_video_params)
        f.html { redirect_to @object_video.redirect_url || redirect_url || object_video_url(@object_video), notice: controller_t('.updated') }
        f.json { render json: @object_video.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @object_video.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /object_videos/1
  def destroy
    @object_video.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || object_videos_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_video
      @object_video = ObjectVideo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def object_video_params
      params.require(:object_video).permit(:local_title, :local_file, :local_file_tmp, :local_file_processing, :local_watermark_image, :youtube_video_id, :object_id, :object_type, :kind, :cancel_url, :redirect_url)
    end
end
