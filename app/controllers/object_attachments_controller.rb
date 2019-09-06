class ObjectAttachmentsController < ApplicationController
  before_action :set_object_attachment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  layout :resolve_layout

  # GET /object_attachments
  def index
    @object_attachments = ObjectAttachment.all
    @object_attachment = ObjectAttachment.new
    @object_attachment.cancel_and_redirect_url_to(object_attachments_url)
    respond_to do |f|
      f.html
      f.json { render json: @object_attachments.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_attachments/1
  def show
    @object_attachment.cancel_and_redirect_url_to(object_attachment_url(@object_attachment))
    respond_to do |f|
      f.html
      f.json { render json: @object_attachment.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_attachments/new
  def new
    @object_attachment = ObjectAttachment.new
    @object_attachment.cancel_url = object_attachments_url
    respond_to do |f|
      f.html
      f.json { render json: @object_attachment.as_json}
      f.js
    end
  end

  # GET /object_attachments/1/edit
  def edit
    @object_attachment.cancel_and_redirect_url_to(object_attachment_url(@object_attachment))
    respond_to do |f|
      f.html
      f.json { render json: @object_attachment.as_json}
      f.js
    end
  end

  # POST /object_attachments
  def create
    @object_attachment = ObjectAttachment.new(object_attachment_params)
    respond_to do |f|
      if @object_attachment.save
        f.html { redirect_to @object_attachment.redirect_url || redirect_url || object_attachment_url(@object_attachment), notice: controller_t('.saved') }
        f.json { render json: @object_attachment.as_json}
        f.js { render :attachments }
      else
        f.html { render :new }
        f.json { render json: @object_attachment.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /object_attachments/1
  def update
    respond_to do |f|
      if @object_attachment.update(object_attachment_params)
        f.html { redirect_to @object_attachment.redirect_url || redirect_url || object_attachment_url(@object_attachment), notice: controller_t('.updated') }
        f.json { render json: @object_attachment.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @object_attachment.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /object_attachments/1
  def destroy
    @object_attachment.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || object_attachments_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :attachments }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_attachment
      @object_attachment = ObjectAttachment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def object_attachment_params
      params.require(:object_attachment).permit(:file, :description, :extension_whitelist, :object_id, :object_type, :cancel_url, :redirect_url)
    end
end
