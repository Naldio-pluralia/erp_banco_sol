class PelourosController < ApplicationController
  before_action :set_pelouro, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /pelouros
  def index
    @pelouros = Pelouro.all
    @pelouro = Pelouro.new
    @pelouro.cancel_and_redirect_url_to(pelouros_url)
    respond_to do |f|
      f.html
      f.json { render json: @pelouros.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /pelouros/1
  def show
    @pelouro.cancel_and_redirect_url_to(pelouro_url(@pelouro))
    respond_to do |f|
      f.html
      f.json { render json: @pelouro.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /pelouros/new
  def new
    @pelouro = Pelouro.new
    @pelouro.cancel_url = pelouros_url
    respond_to do |f|
      f.html
      f.json { render json: @pelouro.as_json}
      f.js
    end
  end

  # GET /pelouros/1/edit
  def edit
    @pelouro.cancel_and_redirect_url_to(pelouro_url(@pelouro))
    respond_to do |f|
      f.html
      f.json { render json: @pelouro.as_json}
      f.js
    end
  end

  # POST /pelouros
  def create
    @pelouro = Pelouro.new(pelouro_params)
    respond_to do |f|
      if @pelouro.save
        f.html { redirect_to @pelouro.redirect_url || redirect_url || pelouro_url(@pelouro), notice: controller_t('.saved') }
        f.json { render json: @pelouro.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @pelouro.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /pelouros/1
  def update
    respond_to do |f|
      if @pelouro.update(pelouro_params)
        f.html { redirect_to @pelouro.redirect_url || redirect_url || pelouro_url(@pelouro), notice: controller_t('.updated') }
        f.json { render json: @pelouro.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @pelouro.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /pelouros/1
  def destroy
    @pelouro.directorates.update_all(pelouro_id: nil)
    @pelouro.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || pelouros_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pelouro
      @pelouro = Pelouro.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pelouro_params
      params.require(:pelouro).permit(:name, :abbreviation, :employee_id, :title, :title_abbreviation, :is_chairman, :cancel_url, :redirect_url, {organic_unit_ids: []})
    end
end
