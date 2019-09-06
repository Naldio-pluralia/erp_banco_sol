class AbsenceDaysController < ApplicationController
  before_action :set_absence_day, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /absence_days
  def index
    @absence_days = AbsenceDay.all
    @absence_day = AbsenceDay.new
    @absence_day.cancel_and_redirect_url_to(absence_days_url)
    respond_to do |f|
      f.html
      f.json { render json: @absence_days.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /absence_days/1
  def show
    @absence_day.cancel_and_redirect_url_to(absence_day_url(@absence_day))
    respond_to do |f|
      f.html
      f.json { render json: @absence_day.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /absence_days/new
  def new
    @absence_day = AbsenceDay.new
    @absence_day.cancel_url = absence_days_url
    respond_to do |f|
      f.html
      f.json { render json: @absence_day.as_json}
      f.js
    end
  end

  # GET /absence_days/1/edit
  def edit
    @absence_day.cancel_and_redirect_url_to(absence_day_url(@absence_day))
    respond_to do |f|
      f.html
      f.json { render json: @absence_day.as_json}
      f.js
    end
  end

  # POST /absence_days
  def create
    @absence_day = AbsenceDay.new(absence_day_params)
    respond_to do |f|
      if @absence_day.save
        f.html { redirect_to @absence_day.redirect_url || redirect_url || absence_day_url(@absence_day), notice: controller_t('.saved') }
        f.json { render json: @absence_day.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @absence_day.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /absence_days/1
  def update
    respond_to do |f|
      if @absence_day.update(absence_day_params)
        f.html { redirect_to @absence_day.redirect_url || redirect_url || absence_day_url(@absence_day), notice: controller_t('.updated') }
        f.json { render json: @absence_day.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @absence_day.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /absence_days/1
  def destroy
    @absence_day.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || absence_days_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absence_day
      @absence_day = AbsenceDay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def absence_day_params
      params.require(:absence_day).permit(:employee_absence_id, :date, :cancel_url, :redirect_url)
    end
end
