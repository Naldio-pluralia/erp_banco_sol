class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, :mark_as_relevant, :mark_as_irrelevant]
  before_action :authenticate_account!, except: [:create_application, :destroy, :update, :edit]
  load_and_authorize_resource
  layout :vacancy_layout

  # GET /applications
  def index
    @applications = Application.all.where.not(name: [nil, '']).where.not(email: [nil, '']).where.not(cellphone: [nil, '']).where(vacancy_id: nil)
    @application = Application.new
    @application.cancel_and_redirect_url_to(applications_url)
    respond_to do |f|
      f.html
      f.json { render json: @applications.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /applications/1
  def show
    @application.cancel_and_redirect_url_to(application_url(@application))
    respond_to do |f|
      f.html
      f.json { render json: @application.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /applications/new
  def new
    @application = Application.new
    @application.cancel_url = candidaturas_url
    respond_to do |f|
      f.html
      f.json { render json: @application.as_json}
      f.js
    end
  end

  # GET /applications/1/edit
  def edit
    @application.cancel_and_redirect_url_to(application_url(@application))
    respond_to do |f|
      f.html
      f.json { render json: @application.as_json}
      f.js
    end
  end

  # POST /applications
  def create
    @application = Application.new(application_params)
    respond_to do |f|
      if @application.save
        f.html { redirect_to @application.redirect_url || redirect_url || application_url(@application), notice: controller_t('.saved') }
        f.json { render json: @application.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @application.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /applications/1
  def update
    respond_to do |f|
      if @application.update(application_params)
        f.html { redirect_to @application.redirect_url || redirect_url || application_url(@application), notice: controller_t('.updated') }
        f.json { render json: @application.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @application.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || vacancies_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  def create_application
    employee =  current&.employee
    @application = Application.create(
      vacancy_id: params[:vacancy_id],
      employee_id: employee&.id,
      name: employee&.name,
      email: employee&.user&.email,
      cellphone: employee&.user&.cellphone,
      cancel_url: candidaturas_url
    )
  end

  def mark_as_relevant
    @application.update_columns(relevance: :relevant)
    redirect_to application_url(@application)
  end

  def mark_as_irrelevant
    @application.update_columns(relevance: :irrelevant)
    redirect_to application_url(@application)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    def vacancy_layout
      if params[:action].eqls?('create_application', 'destroy') && (current_account.nil? || current&.user.nil?)
        'vacancy_layout'
      else
        resolve_layout
      end
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name, :email, :cellphone, :birthdate, :civil_status, :dependents_number, :note, :status, :relevance, :vacancy_id, :employee_id, :cancel_url, :redirect_url)
    end
end
