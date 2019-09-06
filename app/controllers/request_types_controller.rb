class RequestTypesController < ApplicationController
  before_action :set_request_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /request_types
  def index
    @request_types = RequestType.all
    @request_type = RequestType.new
    @request_type.cancel_and_redirect_url_to(request_types_url)
    respond_to do |f|
      f.html
      f.json { render json: @request_types.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /request_types/1
  def show
    @request_type.cancel_and_redirect_url_to(request_type_url(@request_type))
    respond_to do |f|
      f.html
      f.json { render json: @request_type.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /request_types/new
  def new
    @request_type = RequestType.new
    @request_type.cancel_url = request_types_url
    respond_to do |f|
      f.html
      f.json { render json: @request_type.as_json}
      f.js
    end
  end

  # GET /request_types/1/edit
  def edit
    @request_type.cancel_and_redirect_url_to(request_type_url(@request_type))
    respond_to do |f|
      f.html
      f.json { render json: @request_type.as_json}
      f.js
    end
  end

  # POST /request_types
  def create
    @request_type = RequestType.new(request_type_params)

    respond_to do |f|
      if @request_type.save

        data = @request_type.virtual_object_attachments.map{|f| {file: f, object_id: @request_type.id, object_type: @request_type.class.name, description: f.filename}}
        @request_type.object_attachments.create(data)
        @request_type.remove_virtual_object_attachments!

        f.html { redirect_to @request_type.redirect_url || redirect_url || request_type_url(@request_type), notice: controller_t('.saved') }
        f.json { render json: @request_type.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @request_type.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /request_types/1
  def update
    respond_to do |f|
      if @request_type.update(request_type_params)
        f.html { redirect_to @request_type.redirect_url || redirect_url || request_type_url(@request_type), notice: controller_t('.updated') }
        f.json { render json: @request_type.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @request_type.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /request_types/1
  def destroy
    @request_type.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || request_types_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_type
      @request_type = RequestType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def request_type_params
      params.require(:request_type).permit(:name, :note, :requires_supervisor_approval, :requires_supervisor_supervisor_approval, :requires_dpe_approval, :requires_dpe_supervisor_approval, :cancel_url, :redirect_url, {virtual_object_attachments: [], virtual_object_attachments_cache: [], virtual_object_attachments_small: []})
    end
end
