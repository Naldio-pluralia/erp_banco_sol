include ContentTagsHelper
class Nextsgad::EmployeesController < NextSgad::EmployeesController
  before_action :authenticate_account!
  load_and_authorize_resource
  before_action :set_employee, only: [:notification, :notification_read_all, :show, :edit, :update, :destroy, :assessment, :employee_show, :create_objective, :partial_view_list_employee_salaries, :partial_view_list_employee_paygrades, :partial_view_list_employee_work_periods, :team_member_data, :presence]
  before_action :set_assessment, only: [:new_employee_ogbjective, :create_employee_objective]
  layout :resolve_layout  #"partial_view_application", only: [:partial_view_list_employee_salaries, :partial_view_list_employee_paygrades, :partial_view_list_employee_work_periods]

  # GET /employees
  def index
    unless params[:format] == "json"
      @employee = Employee.new
      @upload = Upload.new(type: 'employees')

      # @o = Department.all.group_by {|d| [d.class.name, d.id]}
      # @o.merge(Position.all.group_by {|d| [d.class.name, d.id]})
      # @o.merge(Employee.all.group_by {|d| [d.class.name, d.id]})

      @employees = Employee.all.includes(:latest_paygrade)
                        .department_id(params[:department_id])
                        .organic_unit_id(params[:organic_unit_id])
                        .function_id(params[:function_id])
                        .employee_id(params[:employee_id])
                        .position_id(params[:position_id])
                        .paygrade(params[:paygrade])
                        .level(params[:level])
    end
    #.paginate(page: params[:page], per_page: 10) #if current.is?(:admin)
    respond_to do |format|
      format.html
      format.xls do
        # TODO send this data block to a file
        # TODO check between xls.erb and rb to do so
        book = Spreadsheet::Excel::Workbook.new

        sheet = book.create_worksheet name: I18n.t(:employees)
        sheet.row(0).concat [I18n.t('employees')]
        sheet.row(1).concat [I18n.t('employee_name'), I18n.t('employee_number'), I18n.t('employee_paygrade'), I18n.t('employee_paygrade_level')]
        @employees.each_with_index do |f, index|
          sheet.row(2 + index).concat [f.first_and_last_name, f.number, f.paygrade, f.level]
        end

        file_contents = StringIO.new
        book.write file_contents
        send_data file_contents.string, filename: "#{I18n.t('employees')}.xls", :type => "application/vnd.ms-excel"
      end
      format.pdf do
        send_data Employees.new(@employees, params, current, view_context).render, filename: "#{t :employees}.pdf", type: 'application/pdf', disposition: 'inline'
      end
      format.json{
        @employees = Employee.paginate(page: params[:page], per_page: params[:size]).includes(:latest_paygrade)
                        .department_id(params[:department_id])
                        .function_id(params[:function_id])
                        .employee_id(params[:employee_id])
                        .position_id(params[:position_id])
                        .paygrade(params[:paygrade])
                        .level(params[:level])
        render json: {last_page: @employees.total_pages, data: @employees.as_json}
      }
    end
  end

  # GET /employees/1
  def show
    @assessment = Assessment.get_assessment(params[:year])
    @employee = Employee
                    .includes(:efective_position, :employee_work_periods, :employee_salary_families, :latest_paygrade, {employee_goals: :goal})
                    .find(params[:id])
    @employee.cancel_and_redirect_url_to(employee_url(@employee.id))
    params[:year] ||= @assessment&.year || DateTime.now.year

    respond_to do |format|
      format.html{render :employee_data}
      format.pdf do
        if params[:pdf_type] == 'self'
          pdf = PdfSelfAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'supervisor'
          pdf = PdfSupervisorAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'final'
          pdf = PdfFinalAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        else
          pdf = DetailsEmployee.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "Detalhes_do_Colaborador_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end
    end
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee.goto_redirect_url_or(employees_url), notice: 'register_was_successfully_created'.ts
    else
      render :new
    end
  end

  def create_objective
    @assessment = Assessment.active.last
    @goal = Goal.new(goal_params)
    @goal.assessment_id = @assessment.id
    @goal.goal_type = "objective"

    if @goal.save
      redirect_to @employee.goto_redirect_url_or(employee_url(@employee)), notice: 'register_was_successfully_created'.ts
    else
      render :new_goal
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      Notification.new_notification(@employee.notification_update_message, @employee, @employee.goto_redirect_url_or(employee_url(@employee)))
      redirect_to @employee.goto_redirect_url_or(employee_url(@employee)), notice: 'register_was_successfully_updated'.ts
    else
      render :edit
    end
  end

  # visualiza uma notificação
  def notification_show
    if params[:notification_id].present?
      id = params[:notification_id].decript.to_i
      redirect_to root_url and return unless id > 0
      notification_employee = NotificationEmployee.find(id)
      redirect_to root_url and return unless notification_employee.present?
      notification_employee.update_status
      @notification = notification_employee.notification
    end
    @notifications_employee = current.employee&.notifications_employee&.unread
  end

  # Marca uma notificação como lida
  def notification_read
    redirect_to root_url and return unless params[:notification_id].present?
    notification_employee = NotificationEmployee.find(params[:notification_id].decript)
    redirect_to root_url and return unless notification_employee.present?
    notification_employee.update_status
    return
  end

  # marcar todas as notificações como lidas
  def notification_read_all
    current.employee&.mark_all_read
    redirect_to params[:actual_url] || root_url
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    redirect_to employees_url, notice: 'register_was_successfully_destroyed'.ts
  end

  def team_member_data
    @assessment = Assessment.get_assessment(params[:year])
    @employee = Employee
                    .includes(:efective_position, :employee_work_periods, :employee_salary_families, :latest_paygrade, {employee_goals: :goal})
                    .find(params[:id])
    @employee.cancel_and_redirect_url_to(team_member_data_url(@employee.id))
    params[:year] ||= @assessment&.year || DateTime.now.year

    respond_to do |format|
      format.html{render :employee_data}
      format.pdf do
        if params[:pdf_type] == 'self'
          pdf = PdfSelfAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'supervisor'
          pdf = PdfSupervisorAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'final'
          pdf = PdfFinalAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        else
          pdf = DetailsEmployee.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "Detalhes_do_Colaborador_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end
    end
  end

  # my team HR details
  def my_team
    @my_team = current.team_members
  end

  # my HR data details
  def my_data
    @assessment = Assessment.get_assessment(params[:year])
    @employee = Employee
                    .includes(:efective_position, :employee_work_periods, :employee_salary_families, :latest_paygrade, {employee_goals: :goal})
                    .find(current.employee&.id)
    @employee.cancel_and_redirect_url_to(my_data_url)
    params[:year] ||= @assessment&.year || DateTime.now.year

    respond_to do |format|
      format.html{render :employee_data}
      format.pdf do
        if params[:pdf_type] == 'self'
          pdf = PdfSelfAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'supervisor'
          pdf = PdfSupervisorAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

        elsif params[:pdf_type] == 'final'
          pdf = PdfFinalAssessmentFile.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        else
          pdf = DetailsEmployee.new(@employee, @assessment, view_context)
          send_data pdf.render, filename: "Detalhes_do_Colaborador_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end
    end
  end

  def my_reports
    @reports = current.employee.reports.where(is_anonymous: false)
    @report = Report.new
    @report.cancel_and_redirect_url_to(my_reports_url)
    respond_to do |f|
      f.html { render "reports/index" }
      f.json { render json: @reports.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def my_requests
    @employee_requests = current.employee.employee_requests
    @employee_request = EmployeeRequest.new
    @employee_request.cancel_and_redirect_url_to(my_requests_url)
    respond_to do |f|
      f.html{ render "employee_requests/index" }
      f.json { render json: @employee_requests.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def new_employee_objective
    hash = goal_params rescue {}
    @goal = Goal.new(hash.merge({employee_id: @employee.id, assessment_id: @assessment.id, position_ids: [@employee.efective_position.id], goal_type: :objective}))
    render 'nextsgad/goals/new'
  end

  def create_employee_objective
    @goal = Goal.new(goal_params.merge({employee_id: @employee.id, assessment_id: @assessment.id, position_ids: [@employee.efective_position.id], goal_type: :objective}))
    if @goal.save
      redirect_to @goal.redirect_url || employee_url(@goal.assessment), notice: 'register_was_successfully_created'.ts
    else
      render 'nextsgad/goals/new'
    end
  end

  def assessment
    # @employee_paygrade = EmployeePaygrade.new(employee_id: @employee.id)
    # @employee_work_period = EmployeeWorkPeriod.new(employee_id: @employee.id)

    # @employee_paygrade.cancel_url = employee_assessment_url(@employee, active_tab: :tab_remuneration)
    # @employee_work_period.cancel_url = employee_assessment_url(@employee, active_tab: :tab_remuneration)

    # @result = Result.new
    # @employee_work_periods = EmployeeWorkPeriod.where(employee_id: @employee.id).order(since: :desc).limit(7)
    # @employee_paygrades = EmployeePaygrade.where(employee_id: @employee.id).order(since: :desc).limit(7)

    # @salaries = @employee.salaries.order(period: :desc).limit(7)#.where_date(:period, year: params[:year])

    # @assessment = Assessment.get_assessment(params[:year])
    # params[:year] ||= @assessment&.year || DateTime.now.year
    # @justification = Justification.new(employee_id: @employee.id)
    # @last_paygrade = @employee.employee_paygrades
    # return unless @assessment.present?

    # @objective = Goal.new(assessment_id: @assessment.id, goal_type: :objective, redirect_url: employee_assessment_url(@employee.id))
    # #@skill = Goal.new(assessment_id: @assessment.id, goal_type: :skill, redirect_url: employee_assessment_url(@employee.id))
    # @goals = @assessment.goals
    # @employee_goals = @employee.employee_goals.where(goal_id: @goals.map(&:id))
    # @o = (@goals + @employee_goals).group_by {|d| [d.class.name, d.id]}



    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     if params[:pdf_type] == 'self'
    #       pdf = PdfSelfAssessmentFile.new(@employee, @assessment, view_context)
    #       send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

    #     elsif params[:pdf_type] == 'supervisor'
    #       pdf = PdfSupervisorAssessmentFile.new(@employee, @assessment, view_context)
    #       send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'

    #     elsif params[:pdf_type] == 'final'
    #       pdf = PdfFinalAssessmentFile.new(@employee, @assessment, view_context)
    #       send_data pdf.render, filename: "employe_assessment_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
    #     else
    #       pdf = DetailsEmployee.new(@employee, @assessment, view_context)
    #       send_data pdf.render, filename: "Detalhes_do_Colaborador_#{@employee.first_name}_#{@employee.last_name}.pdf", type: 'application/pdf', disposition: 'inline'
    #     end
    #   end
    # end
  end

  def my_team_assessment
    @assessment = Assessment.active.last
    @employees = current.team_members if current.manager?

    member_position_ids = current.team_positions.ids # gets supervided_positions
    second_level_positions = Position.where(position_id: member_position_ids) # get second level positions
    @second_level_employees = Employee.where(id: second_level_positions.map(&:efective_id)) # get second level employees

    if @assessment.present?
      @goals = @assessment.goals
      @employee_goals = @assessment.employee_goals
      @employees = Employee.all if current.admin?
      @o = (@goals + @employee_goals).group_by {|d| [d.class.name, d.id]}
    end
  end

  def pick_position
    @position = Position.find_by(id: params[:position_id]) || Position.new
  end

  def select_position
    @position = Position.find_by(id: params[:position_id])

    if @position.nil?

    else
      if @position.update(position_params)
        flash[:notice] = t('updated')
        redirect_to root_url
        Goal.all.each(&:create_employee_goals)
      else
        flash[:error] = t('error_updating')
        redirect_to root_url
      end
    end
  end

  def partial_view_list_employee_paygrades
    @employee_paygrades = @employee.employee_salary_families.order(since: :desc).limit_data(params[:limit])
  end

  def partial_view_list_employee_work_periods
    @employee_work_periods = @employee.employee_work_periods.order(since: :desc).limit_data(params[:limit])
  end

  def partial_view_list_employee_salaries
    @salaries = Salary.where(employee_salary_family_id: EmployeeSalaryFamily.where(employee_id: @employee.id)).order(period: :desc).limit_data(params[:limit])
  end

  def hr_presence_map
    period = params[:period]&.present? ? params['period'] : DateTime.now.strftime("%m/%Y")
    @employee = current.employee
    @employees_list = Employee.includes(:user, efective_position: {function: :directorate}).where.not(id: current.employee&.id).employee_id(params[:employee]).order(:number)
    beginning_of_month = Date.parse(period).beginning_of_month
    end_of_month = Date.parse(period).end_of_month

    respond_to do |format|
      format.html
      format.js
      format.xls
      format.json do
        employees = Employee.employee_id(params[:employee]).paginate(page: params[:page], per_page: params[:size]).order(:number)
        data = {last_page: employees.total_pages, data: []}
        absences = {}
        employee_ids = employees.ids
        EmployeeDelay.where(employee_id: employee_ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.arrived_at.day.to_i, e.arrived_at.month, e.arrived_at.year]] ||= "A#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('delays', 'all')
        EmployeeExit.where(employee_id: employee_ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "S#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('exits', 'all')
        VacationDay.includes(:employee_vacation).where(created_at: beginning_of_month..end_of_month).select{|v| v.approved? || v.pending?}.each{|e| absences[[e.employee_vacation.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "V#{e.employee_vacation.letter}" } if params[:kind].blank? || params[:kind].includes?('vacations', 'all')
        AbsenceDay.includes(:employee_absence).where(created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_absence.employee_id, f.date.day.to_i, f.date.month, f.date.year]] ||= "F#{f.employee_absence&.has_justification? ? f.employee_absence&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('absences', 'all')
        EmployeePresence.where(employee_id: employee_ids).where(created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_id, f.date.day, f.date.month, f.date.year]] ||= "P-#{f.status}" } if params[:kind].blank? || params[:kind].includes?('presences', 'all')
        dates = (curr_date.beginning_of_month..curr_date.end_of_month)
        employees.each do |employee|
          data[:data] << {url: employee_url(employee), employee_name: employee.name_and_number, employee_id: employee.id}.merge(dates.map{|f| [l(f, format: '%d/%m/%Y'), absences[[employee.id, f.day.to_i, f.month.to_i, f.year]]]}.to_h)
        end
        render json: data
      end
      format.pdf do
        pdf = HrPresenceMap.new(current, params, view_context)
        send_data pdf.render, filename: "Mapa de Presenças.pdf", type: 'application/pdf'
      end
    end
  end

  def my_team_presence_map
    period = params[:period]&.present? ? params[:period] : DateTime.now.strftime("%m/%Y")
    @employee = current.employee
    beginning_of_month = Date.parse(period).beginning_of_month
    end_of_month = Date.parse(period).end_of_month
    respond_to do |format|
      format.html
      format.js
      format.xls
      format.json do
        employees = current.team_members.employee_id(params[:employee]).includes(:user).paginate(page: params[:page], per_page: params[:size]).order(:number)
        data = {last_page: employees.total_pages, data: []}
        absences = {}
        EmployeeDelay.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.arrived_at.day.to_i, e.arrived_at.month, e.arrived_at.year]] ||= "A#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('delays', 'all')
        EmployeeExit.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "S#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('exits', 'all')
        VacationDay.includes(:employee_vacation).where(created_at: beginning_of_month..end_of_month).select{|v| v.approved? || v.pending?}.each{|e| absences[[e.employee_vacation.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "V#{e.employee_vacation.letter}" } if params[:kind].blank? || params[:kind].includes?('vacations', 'all')
        AbsenceDay.includes(:employee_absence).where(created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_absence.employee_id, f.date.day.to_i, f.date.month, f.date.year]] ||= "F#{f.employee_absence&.has_justification? ? f.employee_absence&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('absences', 'all')
        EmployeePresence.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_id, f.date.day, f.date.month, f.date.year]] ||= "P-#{f.status}" } if params[:kind].blank? || params[:kind].includes?('presences', 'all')
        dates = (curr_date.beginning_of_month..curr_date.end_of_month)
        employees.each do |employee|
          data[:data] << {url: team_member_data_url(employee), employee_name: employee.name_and_number, employee_id: employee.id}.merge(dates.map{|f| [l(f, format: '%d/%m/%Y'), absences[[employee.id, f.day.to_i, f.month.to_i, f.year]]]}.to_h)
        end
        render json: data
      end
      format.pdf do
        pdf = MyTeamPresenceMap.new(current, params, view_context)
        send_data pdf.render, filename: "Mapa de Presenças da equipa.pdf", type: 'application/pdf'
      end
    end
  end

  def department_presence_map
    period = params[:period]&.present? ? params[:period] : DateTime.now.strftime("%m/%Y")
    @employee = current.employee
    beginning_of_month = Date.parse(period).beginning_of_month
    end_of_month = Date.parse(period).end_of_month
    respond_to do |format|
      format.html
      format.js
      format.xls
      format.json do
        employees = current.my_department_members.employee_id(params[:employee]).includes(:user).paginate(page: params[:page], per_page: params[:size]).order(:number)
        data = {last_page: employees.total_pages, data: []}
        absences = {}
        EmployeeDelay.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.arrived_at.day.to_i, e.arrived_at.month, e.arrived_at.year]] ||= "A#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('delays', 'all')
        EmployeeExit.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "S#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('exits', 'all')
        VacationDay.includes(:employee_vacation).where(created_at: beginning_of_month..end_of_month).select{|v| v.approved? || v.pending?}.each{|e| absences[[e.employee_vacation.employee_id, e.date.day.to_i, e.date.month, e.date.year]] ||= "V#{e.employee_vacation.letter}" } if params[:kind].blank? || params[:kind].includes?('vacations', 'all')
        AbsenceDay.includes(:employee_absence).where(created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_absence.employee_id, f.date.day.to_i, f.date.month, f.date.year]] ||= "F#{f.employee_absence&.has_justification? ? f.employee_absence&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('absences', 'all')
        EmployeePresence.where(employee_id: employees.ids, created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_id, f.date.day, f.date.month, f.date.year]] ||= "P-#{f.status}" } if params[:kind].blank? || params[:kind].includes?('presences', 'all')
        dates = (curr_date.beginning_of_month..curr_date.end_of_month)
        employees.each do |employee|
          data[:data] << {url: '#', employee_name: employee.name_and_number, employee_id: employee.id}.merge(dates.map{|f| [l(f, format: '%d/%m/%Y'), absences[[employee.id, f.day.to_i, f.month.to_i, f.year]]]}.to_h)
        end
        render json: data
      end
      format.pdf do
        pdf = DepartmentPresenceMap.new(current, params, view_context)
        send_data pdf.render, filename: "Mapa de Presenças do departamento.pdf", type: 'application/pdf'
      end
    end
  end



  def my_presence_map
    period = params[:period]&.present? ? params[:period] : DateTime.now.strftime("%m/%Y")
    @employee = current.employee
    beginning_of_month = Date.parse(period).beginning_of_month
    end_of_month = Date.parse(period).end_of_month
    respond_to do |format|
      format.html
      format.js
      format.xls
      format.json do
        employee_ids = @employee.efective_position&.position&.positions&.includes(:efective)&.map(&:efective_id) || [@employee.id]
        employees = Employee.where(id: employee_ids).employee_id(params[:employee]).includes(:user).paginate(page: params[:page], per_page: params[:size]).order(:number)
        data = {last_page: employees.total_pages, data: []}
        absences = {}
        EmployeeDelay.where(employee_id: @employee.id, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.arrived_at.day, e.arrived_at.month, e.arrived_at.year]] ||= "A#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('delays', 'all')
        EmployeeExit.where(employee_id: @employee.id, created_at: beginning_of_month..end_of_month).each{|e| absences[[e.employee_id, e.date.day, e.date.month, e.date.year]] ||= "S#{e&.has_justification? ? e&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('exits', 'all')
        VacationDay.includes(:employee_vacation).where(created_at: beginning_of_month..end_of_month).select{|v| v.approved? || v.pending?}.each{|e| absences[[e.employee_vacation.employee_id, e.date.day, e.date.month, e.date.year]] ||= "V#{e.employee_vacation.letter}" } if params[:kind].blank? || params[:kind].includes?('vacations', 'all')
        AbsenceDay.includes(:employee_absence).where(created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_absence.employee_id, f.date.day, f.date.month, f.date.year]] ||= "F#{f.employee_absence&.has_justification? ? f.employee_absence&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('absences', 'all')
        EmployeePresence.where(employee_id: @employee.id, created_at: beginning_of_month..end_of_month).each{|f| absences[[f.employee_id, f.date.day, f.date.month, f.date.year]] ||= "P-#{f.status}" } if params[:kind].blank? || params[:kind].includes?('presences', 'all')
        employees.each do |employee|
          data[:data] << {url: my_data_url, employee_name: employee.name_and_number, employee_id: employee.id}.merge(curr_date.month_days.map{|f| [l(f, format: '%d/%m/%Y'), absences[[employee.id, f.day.to_i, f.month.to_i, f.year]]]}.to_h)
        end
        render json: data
      end
      format.pdf do
        pdf = MyPresenceMap.new(current, params, view_context)
        send_data pdf.render, filename: "Meu Mapa de Presenças.pdf", type: 'application/pdf'
      end
    end
  end

  def presence

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.includes(:latest_paygrade, {employee_exits: [:employee_justification, :absence_type], employee_delays: [:employee_justification, :absence_type], employee_absences: [:employee_justification, :absence_type]}, :employee_regimes, :employee_goals, :efective_position).find(params[:id])
  end

  def set_assessment
    @assessment = Assessment.find(params[:assessment_id])
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :number, :level, :paygrade, :tolerance, :status, :position_id, :avatar, :can_be_assessed, :cancel_url, :redirect_url)
  end

  # Only allow a trusted parameter "white list" through.
  def goal_params
    params.require(:goal).permit(:name, :goal_type, :status, :nature, :unit, :target, :assessment_id, {position_ids: []})
  end

  # Only allow a trusted parameter "white list" through.
  def position_params
    params.require(:position).permit(:name, :function_id, :efective_id, :position_id, :render_view, :department_id, :description).merge(efective_id: current.employee.id)
  end
end
