class AppliancesController < ApplicationController
  before_action :set_appliance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!, except: [:new, :create]
  load_and_authorize_resource
  layout :vacancy_layout

  # GET /appliances
  def index
    @appliances = Appliance.all
    @appliance = Appliance.new
    @appliance.cancel_and_redirect_url_to(appliances_url)
    respond_to do |f|
      f.html
      f.json { render json: @appliances.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /appliances/1
  def show
    @appliance.cancel_and_redirect_url_to(appliance_url(@appliance))
    respond_to do |f|
      f.html
      f.json { render json: @appliance.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /appliances/new
  def new
    @appliance = Appliance.new
    @appliance.cancel_and_redirect_url_to(params[:redirect_to])
    respond_to do |f|
      f.html
      f.json { render json: @appliance.as_json}
      f.js
    end
  end

  # GET /appliances/1/edit
  def edit
    @appliance.cancel_and_redirect_url_to(appliance_url(@appliance))
    respond_to do |f|
      f.html
      f.json { render json: @appliance.as_json}
      f.js
    end
  end

  # POST /appliances
  def create
    @appliance = Appliance.new(appliance_params)
    respond_to do |f|
      if @appliance.save
        f.html { redirect_to @appliance.redirect_url, notice: controller_t('.saved') }
        f.json { render json: @appliance.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @appliance.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /appliances/1
  def update
    respond_to do |f|
      if @appliance.update(appliance_params)
        f.html { redirect_to @appliance.redirect_url || redirect_url || appliance_url(@appliance), notice: controller_t('.updated') }
        f.json { render json: @appliance.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @appliance.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /appliances/1
  def destroy
    @appliance.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || appliances_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appliance
      @appliance = Appliance.find(params[:id])
    end

    def vacancy_layout
      if params[:action].eqls?('new', 'create')
        'vacancy_layout'
      else
        resolve_layout
      end
    end

    # Only allow a trusted parameter "white list" through.
    def appliance_params
      params.require(:appliance).permit(:name, :email, :cellphone, :note, :relevance, :resume, :cancel_url, :redirect_url, attachments: [])
    end
end
