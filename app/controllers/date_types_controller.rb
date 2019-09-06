class DateTypesController < ApplicationController
  before_action :set_date_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /date_types
  def index
    @date_types = DateType.all.order(date: :asc)
    @date_type = DateType.new
    @date_type.cancel_and_redirect_url_to(date_types_url)
    respond_to do |f|
      f.html
      f.json { render json: @date_types.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /date_types/1
  def show
    @date_type.cancel_and_redirect_url_to(date_type_url(@date_type))
    respond_to do |f|
      f.html
      f.json { render json: @date_type.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /date_types/new
  def new
    @date_type = DateType.new
    @date_type.cancel_url = date_types_url
    respond_to do |f|
      f.html
      f.json { render json: @date_type.as_json}
      f.js
    end
  end

  # GET /date_types/1/edit
  def edit
    @date_type.cancel_and_redirect_url_to(date_type_url(@date_type))
    respond_to do |f|
      f.html
      f.json { render json: @date_type.as_json}
      f.js
    end
  end

  # POST /date_types
  def create
    @date_type = DateType.new(date_type_params)
    respond_to do |f|
      if @date_type.save
        f.html { redirect_to @date_type.redirect_url || date_type_url(@date_type), notice: controller_t('.saved') }
        f.json { render json: @date_type.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @date_type.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /date_types/1
  def update
    respond_to do |f|
      if @date_type.update(date_type_params)
        f.html { redirect_to @date_type.redirect_url || date_type_url(@date_type), notice: controller_t('.updated') }
        f.json { render json: @date_type.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @date_type.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /date_types/1
  def destroy
    @date_type.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || date_types_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_type
      @date_type = DateType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def date_type_params
      params.require(:date_type).permit(:name, :description, :date, :kind, :recurrent, :cancel_url, :redirect_url)
    end
end
