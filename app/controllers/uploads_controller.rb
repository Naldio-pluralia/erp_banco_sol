class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]
  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
    respond_to do |format|
      if @upload.valid?
        @upload.read_data
        format.html {redirect_to @redirect_to || uploads_url, notice: 'register_was_successfully_updated'.ts}
        format.js
        # format.json { render json: @upload.read_data.to_json, status: :ok }
      else
        format.html {render :new}
        format.json {render json: @upload.errors, status: :unprocessable_entity}
      end
    end
  end

  def upload_departments
    @upload = Upload.new(type: 'departments')
    @departments = []
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def create_departments
    @departments = Department.create(departments_params)
    @departments = @departments.map {|f| f if f.id.nil?}.compact
    @upload = Upload.new(type: 'departments')
    if @departments.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to departments_url
    else
      render :upload_departments
    end
  end

  def upload_functions
    @upload = Upload.new(type: 'functions')
    @functions = []
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def create_functions
    @functions = Function.create(functions_params)
    @functions = @functions.map {|f| f if f.id.nil?}.compact
    @upload = Upload.new(type: 'functions')
    if @functions.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to functions_url
    else
      render :upload_functions
    end
  end

  def upload_positions
    @upload = Upload.new(type: 'positions')
    @positions = []
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def create_positions
    @positions = Position.create(positions_params)
    @positions = @positions.map {|f| f if f.id.nil?}.compact
    @upload = Upload.new(type: 'positions')
    if @positions.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to positions_url
    else
      render :upload_positions
    end
  end

  def upload_employees
    @upload = Upload.new(type: 'employees')
    @employees = []

  end

  def create_employees
    @employees = Employee.create(employees_params)
    @employees = @employees.map {|f| f if f.id.nil? && f.first_name.present?}.compact
    @upload = Upload.new(type: 'employees')
    if @employees.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to employees_url
    else
      render :upload_employees
    end
  end

  def upload_attendances
    @upload = Upload.new(type: 'attendances')
    @attendances = []
  end

  def create_attendances
    @attendances = Attendance.create(attendances_params)
    @attendances = @attendances.map {|f| f if f.id.nil?}.compact
    @upload = Upload.new(type: 'attendances')
    if @attendances.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to attendances_url
    else
      render :upload_attendances
    end
  end

  def upload_users
    @upload = Upload.new(type: 'users')
    @users = []
  end

  def create_users
    @users = User.create(users_params) do |u|
      u.temporary_password = rand(2**256).to_s(36).ljust(1, 'a')[0..9]
      u.password = u.temporary_password
      u.password_confirmation = u.temporary_password
      # UserMailer.welcome_email(u, u.temporary_password).deliver_later
    end

    @users.each{|u| UserMailer.welcome_email(u, u.temporary_password).deliver_later if @user.id.present?}

    @users = @users.map {|f| f if f.id.nil?}.compact
    @upload = Upload.new(type: 'users')
    if @users.size <= 0
      flash[:notice] = 'register_was_successfully_updated'.ts
      redirect_to users_url
    else
      render :upload_users
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def upload_params
    params.require(:upload).permit(:file, :type)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def departments_params
    params.require(:departments).map {|m| m.permit(:name, :department_id, :number)}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def functions_params
    params.require(:functions).map {|m| m.permit(:name, :number)}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employees_params
    params.require(:employees).map {|m| m.permit(:first_name, :middle_name, :last_name, :number, :level, :paygrade, :new_position, :position_name, :position_function_id, :position_position_id, :position_department_id, :new_account, :user_email)}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def positions_params
    params.require(:positions).map {|m| m.permit(:name, :number, :function_id, :efective_id, :department_id, :position_id)}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def users_params
    params.require(:users).map {|m| m.permit(:first_name, :middle_name, :last_name, :email, :employee_id)}
  end
end