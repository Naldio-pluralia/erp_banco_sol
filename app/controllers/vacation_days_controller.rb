class VacationDaysController < ApplicationController
  before_action :set_vacation_day, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /vacation_days
  def index
    @vacation_days = VacationDay.all
    @vacation_day = VacationDay.new
    @vacation_day.cancel_and_redirect_url_to(vacation_days_url)
    respond_to do |f|
      f.html
      f.json { render json: @vacation_days.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /vacation_days/1
  def show
    @vacation_day.cancel_and_redirect_url_to(vacation_day_url(@vacation_day))
    respond_to do |f|
      f.html
      f.json { render json: @vacation_day.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /vacation_days/new
  def new
    @vacation_day = VacationDay.new
    @vacation_day.cancel_url = vacation_days_url
    respond_to do |f|
      f.html
      f.json { render json: @vacation_day.as_json}
      f.js
    end
  end

  # GET /vacation_days/1/edit
  def edit
    @vacation_day.cancel_and_redirect_url_to(vacation_day_url(@vacation_day))
    respond_to do |f|
      f.html
      f.json { render json: @vacation_day.as_json}
      f.js
    end
  end

  # POST /vacation_days
  def create
    @vacation_day = VacationDay.new(vacation_day_params)
    respond_to do |f|
      if @vacation_day.save
        f.html { redirect_to @vacation_day.redirect_url || redirect_url || vacation_day_url(@vacation_day), notice: controller_t('.saved') }
        f.json { render json: @vacation_day.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @vacation_day.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /vacation_days/1
  def update
    respond_to do |f|
      if @vacation_day.update(vacation_day_params)
        f.html { redirect_to @vacation_day.redirect_url || redirect_url || vacation_day_url(@vacation_day), notice: controller_t('.updated') }
        f.json { render json: @vacation_day.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @vacation_day.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /vacation_days/1
  def destroy
    @vacation_day.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || vacation_days_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation_day
      @vacation_day = VacationDay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vacation_day_params
      params.require(:vacation_day).permit(:employee_vacation_id, :employee_avaliable_vacation_id, :date, :cancel_url, :redirect_url)
    end
end
