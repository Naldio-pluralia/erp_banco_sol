class DirectoratesController < ApplicationController
  before_action :set_directorate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /directorates
  def index
    @directorates = Directorate.all
    @directorate = Directorate.new
    @directorate.cancel_and_redirect_url_to(directorates_url)
    respond_to do |f|
      f.html
      f.json { render json: @directorates.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /directorates/1
  def show
    @directorate.cancel_and_redirect_url_to(directorate_url(@directorate))
    respond_to do |f|
      f.html
      f.json { render json: @directorate.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /directorates/new
  def new
    @directorate = Directorate.new
    @directorate.cancel_url = directorates_url
    respond_to do |f|
      f.html
      f.json { render json: @directorate.as_json}
      f.js
    end
  end

  # GET /directorates/1/edit
  def edit
    @directorate.cancel_and_redirect_url_to(directorate_url(@directorate))
    respond_to do |f|
      f.html
      f.json { render json: @directorate.as_json}
      f.js
    end
  end

  # POST /directorates
  def create
    @directorate = Directorate.new(directorate_params)
    respond_to do |f|
      if @directorate.save
        f.html { redirect_to @directorate.redirect_url || redirect_url || directorate_url(@directorate), notice: controller_t('.saved') }
        f.json { render json: @directorate.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @directorate.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /directorates/1
  def update
    respond_to do |f|
      if @directorate.update(directorate_params)
        f.html { redirect_to @directorate.redirect_url || redirect_url || directorate_url(@directorate), notice: controller_t('.updated') }
        f.json { render json: @directorate.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @directorate.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /directorates/1
  def destroy
    @directorate.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || directorates_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directorate
      @directorate = Directorate.includes(:directorate_area).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def directorate_params
      params.require(:directorate).permit(:name, :directorate_area_id, :pelouro_id, :abbreviation, :cancel_url, :redirect_url)
    end
end
