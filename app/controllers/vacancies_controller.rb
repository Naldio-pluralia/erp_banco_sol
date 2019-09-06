class VacanciesController < ApplicationController
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!, except: [:index, :show]
  load_and_authorize_resource
  layout :vacancy_layout

  # GET /vacancies
  def index
    @vacancies = Vacancy.filter(:contract_type, params[:contract_type]).filter(:id, params[:position]).filter(:id, params[:ref_number])
    @vacancy = Vacancy.new
    @vacancy.cancel_and_redirect_url_to(vacancies_url)
    respond_to do |f|
      f.html
      f.json { render json: @vacancies.as_json}
      f.js { render resolve_render }
      f.xls
      f.pdf
    end
  end

  # GET /vacancies/1
  def show
    @vacancy.cancel_and_redirect_url_to(vacancy_url(@vacancy))
    respond_to do |f|
      f.html
      f.json { render json: @vacancy.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new
    @vacancy.cancel_url = vacancies_url
    respond_to do |f|
      f.html
      f.json { render json: @vacancy.as_json}
      f.js
    end
  end

  # GET /vacancies/1/edit
  def edit
    @vacancy.cancel_and_redirect_url_to(vacancy_url(@vacancy))
    respond_to do |f|
      f.html
      f.json { render json: @vacancy.as_json}
      f.js
    end
  end

  # POST /vacancies
  def create
    @vacancy = Vacancy.new(vacancy_params)
    respond_to do |f|
      if @vacancy.save
        f.html { redirect_to @vacancy.redirect_url || redirect_url || vacancy_url(@vacancy), notice: controller_t('.saved') }
        f.json { render json: @vacancy.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @vacancy.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  def update
    respond_to do |f|
      if @vacancy.update(vacancy_params)
        f.html { redirect_to @vacancy.redirect_url || redirect_url || vacancy_url(@vacancy), notice: controller_t('.updated') }
        f.json { render json: @vacancy.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @vacancy.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /vacancies/1
  def destroy
    @vacancy.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || vacancies_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    def vacancy_layout
      if params[:action].eqls?('index', 'show') && (current_account.nil? || current&.user&.id.nil?)
        'vacancy_layout'
      else
        resolve_layout
      end
    end

    # Only allow a trusted parameter "white list" through.
    def vacancy_params
      params.require(:vacancy).permit(:position, :requirements, :number, :status, :target, :contract_type, :offer_ends_at, :country, :city, :province, :job_description, :year_of_experience, :cancel_url, :redirect_url)
    end
end
