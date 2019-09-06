module Nextsgad
  class AttendancesController < NextSgad::AttendancesController
    before_action :authenticate_account!
    load_and_authorize_resource class: Attendance
    before_action :set_attendance, only: [:show, :edit, :update, :destroy]

    # GET /attendances
    def index
      @attendances = Attendance.all
                         .employee_id(params[:employee_id])
                         .position_id(params[:position_id])
                         .justification_status(params[:justification_status])
      @attendance = Attendance.new
      @upload = Upload.new(type: 'attendances')
    end

    # GET /attendances/1
    def show
      @justification = Justification.new(employee_id: @attendance.employee_id, attendance_ids: [@attendance.id], redirect_url: attendance_url(@attendance))
    end

    # GET /attendances/new
    def new
      @attendance = Attendance.new
    end

    # GET /attendances/1/edit
    def edit
    end

    # POST /attendances
    def create

      @attendance = Attendance.new(attendance_params)
      @assessment = Assessment.where(year: @attendance.date&.year).last

      if @attendance.save
        redirect_to params[:redirect_url] || attendances_url, notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /attendances/1
    def update
      if @attendance.update(attendance_params)
        redirect_to @attendance, notice: 'register_was_successfully_updated'.ts
      else
        render :edit
      end
    end

    # DELETE /attendances/1
    def destroy
      @attendance.destroy
      redirect_to attendances_url, notice: 'register_was_successfully_destroyed'.ts
    end

    # where the employee sees his attendances
    def my_attendances
      @attendances = Attendance.where(employee_id: current.employee.id)
      @attendance = Attendance.new
      @justification = Justification.new(employee_id: current.employee.id)
      @upload = Upload.new(type: 'attendances')
    end

    # where the manager sees his team attendances
    def my_team_attendances
      @attendances = Attendance.where(employee_id: current.team_members.ids)
      @attendance = Attendance.new
      @upload = Upload.new(type: 'attendances')
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attendance_params
      params.require(:attendance).permit(:date, :status, :employee_note, :supervisor_note, :employee_id, :position_id, :assessment_id)
    end
  end
end
