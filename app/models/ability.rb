class Ability
  include CanCan::Ability

  def initialize(current)
    # Define abilities for the passed in user here. For example:
    #
    current.user ||= User.new
    user = current.user
    team_members = current.team_members.to_a
    team_member_ids = team_members.map(&:id)
    team_team_members = current.team_team_members.to_a
    team_team_member_ids = team_team_members.map(&:id)
    team_positions = current.team_positions.to_a
    team_position_ids = team_positions.map(&:id)
    team_team_positions = current.team_team_positions.to_a
    team_team_position_ids = team_team_positions.map(&:id)
    employee = current.employee
    employee_id = employee&.id

    # creates permissions
    user.permissions.each do |permission|
      action, model = permission.split(',')[0], permission.split(',')[1]
      next if action.blank? or model.blank?
      begin
        model = model.gsub('nextsgad/', '').classify.constantize
      rescue
        p $!.backtrace
        next
      end

      can action.to_sym, model
      # to prevent duplication, update will be user to both update and edit and so as create with new
      dup = {update: :edit, create: :new}
      if dup[action.to_sym].present?
        can dup[action.to_sym].to_sym, model
      end
    end

    can :manage, :all if current.is?(:admin)

    # Province -------------------------------------------------------------------------------------
    can :manage, Province if current.is?(:hr)

    # Application -------------------------------------------------------------------------------------
    can :manage, Municipality if current.is?(:hr)

    # Municipe -------------------------------------------------------------------------------------
    can :manage, Application if current.is?(:hr)

    # Establishment Type -------------------------------------------------------------------------------------
    can :manage, EstablishmentType if current.is?(:hr)

    # Establishment -------------------------------------------------------------------------------------
    can :manage, Establishment if current.is?(:hr)

    # Organic unit type -------------------------------------------------------------------------------------
    can :manage, OrganicUnitType if current.is?(:hr)

    # Organic unit -------------------------------------------------------------------------------------
    can :manage, OrganicUnit if current.is?(:hr)

    # Application -------------------------------------------------------------------------------------
    can :manage, Application if current.is?(:hr)
    can :show, Application
    can :update, Application
    can :destroy, Application if current.user.id.nil? || current.is?(:hr)
    can :create_application, Application
    cannot :mark_as_irrelevant, Application
    cannot :mark_as_relevant, Application
    can :mark_as_irrelevant, Application do |f|
      current.is?(:hr) && (f.unset? || f.relevant?)
    end
    can :mark_as_relevant, Application do |f|
      current.is?(:hr) && (f.unset? || f.irrelevant?)
    end
    # ----------------------------------------------------------------------------------------------

    # Assessment -------------------------------------------------------------------------------------
    can :manage, Assessment if current.is?(:hr) ##

    cannot :new_skill, Assessment do |f|
      !(f.active? && current.is?(:manager))
    end
    cannot :new_objective, Assessment do |f|
      !(f.active? && current.is?(:manager))
    end
    cannot :activate, Assessment do |f|
      !((f.draft? || f.inactive?) && Assessment.active.none?)
    end
    cannot :close, Assessment do |f|
      f.closed?
    end
    cannot :deactivate, Assessment do |f|
      !(f.active?)
    end
    cannot :draft, Assessment do |f|
      f.draft?
    end
    cannot :destroy, Assessment do |f|
      not f.draft?
    end

    # AbsenceType ----------------------------------------------------------------------------------
    can :manage, AbsenceType if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # Approver ----------------------------------------------------------------------------------
    can [:new, :edit, :create, :update], Approver if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    can :manage, EmployeeAbsence if current.is?(:employee, :hr)
    can :manage, EmployeeExit if current.is?(:employee, :hr)
    can :manage, EmployeeDelay if current.is?(:employee, :hr)
    can :manage, EmployeeJustification if current.is?(:employee, :hr)
    cannot :manage, JustificationAnswer
    can :update, JustificationAnswer do |f|
      not_his_own_absence = f.employee_justification&.absence&.employee_id != employee_id
      is_his_answer = f.employee_id.present? && f.employee_id == employee_id
      is_an_approver = f.employee_justification.approvers.select{|a| a.employee_id == employee_id && f.kind == a.kind }.any?
      not_justifing_two_roles = f.employee_justification.justification_answers.where.not(id: f.id).where(employee_id: employee_id).none?
      not_his_own_absence && (is_his_answer || is_an_approver) && not_justifing_two_roles
    end

    cannot :new_skills_from_last_year, Assessment do |f|
      not_a_manager = !current.is?(:manager, :hr, :admin)
      cannot_copy_skills = !f.can_copy_last_years_skills?
      not_a_manager || cannot_copy_skills
    end

    cannot :create_skills_from_last_year, Assessment do |f|
      not_a_manager = !current.is?(:manager, :hr, :admin)
      cannot_copy_skills = !f.can_copy_last_years_skills?
      not_a_manager || cannot_copy_skills
    end
    # ----------------------------------------------------------------------------------------------

    # Gols -----------------------------------------------------------------------------------------

    can :manage, GeneralGoal    if current.is?(:hr, :admin)
    can :manage, TeamGoal       if current.is?(:hr, :admin)
    can :manage, CorporateGoal  if current.is?(:hr, :admin)
    #can :manage, IndividualGoal if current.is?(:hr, :admin, :manager)

    # ----------------------------------------------------------------------------------------------

    # Appliance ---------------------------------------------------------------------------------
    can :manage, Appliance if current.is?(:hr)
    can [:new, :create], Appliance
    # ---------------------------------------------------------------------------------------------


    # Attendances ---------------------------------------------------------------------------------
    can :manage, Attendance if current.is?(:hr)
    cannot :my_attendances, Attendance unless current.is?(:employee) ##
    cannot :my_team_attendances, Attendance unless current.is?(:manager) ##
    can :my_attendances, Attendance if current.is?(:employee) ##
    cannot :my_attendances, Attendance if current.is?(:employee) && current.employee.is_not_assessed?##
    can :my_team_attendances, Attendance if current.is?(:manager) ##
    can :new, Attendance if current.is?(:manager) ##
    can :create, Attendance if current.is?(:manager) ##
    # ---------------------------------------------------------------------------------------------

    # Group ----------------------------
    can :manage, Group if current.is?(:manager, :admin, :hr)
    #can :manage, Group if current.is?(:manager, :admin)

    # Course ----------------------------------------------------------------------------------
    can :manage, Course if current.is?(:hr)
    cannot :report_courses, Course
    cannot :statistics, Course
    can :statistics, Course do |f|
      !f.draft? && current.is?(:hr, :admin)
    end
    cannot :my_training, Course
    can :my_training, Course if current.is?(:employee) ##
    cannot [:edit, :update, :destroy, :open, :close, :draft], Course
    can [:edit, :update, :destroy, :open, :close, :draft], Course do |f|
      f.draft? && current.is?(:hr, :admin)
    end
    cannot [:start, :continue, :remake], Course
    can [:start, :continue, :remake], Course do |f|
      f.opened? && current.is?(:employee)
    end
    cannot :start, Course
    can :start, Course do |f|
      f.opened? && current.is?(:employee) && f.employee_courses.where(employee_id: employee_id).none? && (f.for_all || f.obligated_function_ids.include?(current.function&.id) || f.optional_function_ids.include?(current.function&.id))
    end
    cannot :see, Course
    can :see, Course do |f|
      f.opened? && current.is?(:employee) && f.employee_courses.in_progress.where(employee_id: employee_id).none? && f.employee_courses.done.where(employee_id: employee_id).exists?
    end
    cannot :continue, Course
    can :continue, Course do |f|
      f.opened? && current.is?(:employee) && f.employee_courses.in_progress.where(employee_id: employee_id).exists?
    end
    cannot :restart, Course
    can :restart, Course do |f|
      f.opened? && current.is?(:employee) && f.employee_courses.done.where(employee_id: employee_id).exists? && f.employee_courses.in_progress.where(employee_id: employee_id).none?
    end
    cannot :open, Course
    can :open, Course do |f|
      f.closed? || f.draft?
    end
    cannot :close, Course
    can :close, Course do |f|
      f.opened?
    end
    cannot :draft, Course
    can :draft, Course do |f|
      f.opened?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeCourse ---------------------------------------------------------------------------
    cannot :manage, EmployeeCourse
    can :show, EmployeeCourse do |f|
      employee_id == f.employee_id && f.course.opened?
    end
    can :complete, EmployeeCourse do |f|
      f.conclusion_percentage == 100 && f.in_progress? && employee_id == f.employee_id && f.course.opened?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeChapter ---------------------------------------------------------------------------
    cannot :manage, EmployeeChapter
    can :manage, EmployeeChapter do |f|
      employee_course = f.employee_course
      employee_id == employee_course.employee_id && employee_course.course.opened?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeLesson ---------------------------------------------------------------------------
    cannot :manage, EmployeeLesson
    can [:show, :watch], EmployeeLesson do |f|
      employee_course = f.employee_chapter.employee_course
      employee_id == employee_course.employee_id && employee_course.course.opened?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeExam ---------------------------------------------------------------------------
    cannot :manage, EmployeeExam
    can [:show, :start], EmployeeExam do |f|
      employee_course = f.employee_chapter.employee_course
      employee_id == employee_course.employee_id && employee_course.course.opened?
    end
    can :complete, EmployeeExam do |f|
      f.employee_questions.not_done.empty? && f.not_done?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeQuestionOption -------------------------------------------------------------------
    cannot :manage, EmployeeQuestionOption
    can [:select], EmployeeQuestionOption do |f|
      employee_course = f.employee_question.employee_exam.employee_chapter.employee_course
      employee_id == employee_course.employee_id && f.employee_question.employee_exam.not_done?
    end
    # ------------------------------------------------------------------------------------------

    # EmployeeAnswer -------------------------------------------------------------------
    cannot :manage, EmployeeAnswer
    can [:update], EmployeeAnswer do |f|
      employee_course = f.employee_question.employee_exam.employee_chapter.employee_course
      employee_id == employee_course.employee_id && f.employee_question.employee_exam.not_done?
    end
    # ------------------------------------------------------------------------------------------

    # Chapter ----------------------------------------------------------------------------------
    can :manage, Chapter if current.is?(:hr)
    cannot :create_exam, Chapter
    can :create_exam, Chapter do |f|
      f.course.draft? && f.exam.nil?
    end
    # -----------------------------------------------------------------------------------------

    # Lesson ----------------------------------------------------------------------------------
    can :manage, Lesson if current.is?(:hr)
    cannot [:edit, :update, :destroy], Lesson do |f|
      !f.course.draft?
    end
    # -----------------------------------------------------------------------------------------

    # Exam ------------------------------------------------------------------------------------
    can :manage, Exam if current.is?(:hr)
    cannot [:edit, :update, :destroy], Exam do |f|
      !f.course.draft?
    end
    # ------------------------------------------------------------------------------------------

    # Question ---------------------------------------------------------------------------------
    can :manage, Question if current.is?(:hr)
    cannot [:edit, :update, :destroy], Question do |f|
      !f.exam.chapter.course.draft?
    end
    # ------------------------------------------------------------------------------------------

    # QuestionOption ---------------------------------------------------------------------------
    can :manage, QuestionOption if current.is?(:hr)
    cannot [:edit, :update, :destroy], QuestionOption do |f|
      !f.course.draft?
    end
    # ------------------------------------------------------------------------------------------

    # DirectorateArea -------------------------------------------------------------------------------
    can :manage, DirectorateArea if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # Directorate -------------------------------------------------------------------------------
    can :manage, Directorate if current.is?(:hr)
    cannot :destroy, Directorate do |f|
      f.cannot_destroy?
    end
    # ---------------------------------------------------------------------------------------------

    # Department -------------------------------------------------------------------------------
    can :manage, Department if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # DateType ----------------------------------------------------------------------------------
    can :manage, DateType if current.is?(:hr)

    # ---------------------------------------------------------------------------------------------

    # Employee  -----------------------------------------------------------------------------------
    can :manage, Employee if current.is?(:hr)
    can [:partial_view_list_employee_paygrades, :partial_view_list_employee_work_periods, :partial_view_list_employee_salaries], Employee
    can :my_data, Employee if current.is?(:employee) ##
    cannot :my_reports, Employee
    cannot :my_requests, Employee
    can :my_reports, Employee if current.is?(:employee) ##
    can :my_requests, Employee if current.is?(:employee) ##
    can :my_team_assessment, Employee if current.is?(:manager) ##
    cannot :hr_presence_map, Employee unless current.is?(:admin)
    can :hr_presence_map, Employee if current.is?(:hr) ##
    cannot :my_team_presence_map, Employee

    cannot :department_presence_map, Employee
    can :department_presence_map, Employee if current.is?(:department_lider) ##

    can :my_team_presence_map, Employee if current.is?(:manager) ##
    cannot :my_presence_map, Employee
    can :my_presence_map, Employee if current.is?(:employee) ##
    cannot :presence, Employee unless current.is?(:admin)

    # notification
    can :manage, Notification
    can :notification_show, Employee
    can :notification_read, Employee
    can :notification_read_all, Employee

    can :presence, Employee do |f|
      current.is?(:hr) || team_members.include?(f) || (current.is?(:employee) && employee_id == f.id)
    end
    cannot :mark_presence, EmployeeAbsence
    can :mark_presence, EmployeeAbsence do |f|
      current.is?(:employee) && f.employee_id == employee_id && f.absence_type.is_system_absence && (f.left_at...f.returned_at).include?(Date.current)
    end
    cannot :mark_employee_presence, EmployeeAbsence
    can :mark_employee_presence, EmployeeAbsence do |f|
      current_date = Date.current
      (current.is?(:hr) || team_member_ids.include?(f.employee_id) || current.is?(:admin)) && f.absence_type.is_system_absence
    end
    cannot :manage, EmployeePresence
    can :confirm_employee_presence, EmployeePresence do |f|
      f.unconfirmed? && ((current.is?(:hr) && f.employee_id != employee_id) || team_member_ids.include?(f.employee_id) || current.is?(:admin))
    end
    can [:new_presence, :create_presence], EmployeePresence if current.is?(:hr, :manager, :admin)
    #can [:new_vacation, :create_vacation], EmployeeVacation

    cannot :my_data, Employee unless current.is?(:employee)
    can :team_member_data, Employee do |f|
      team_members.include?(f) || team_team_members.include?(f)
    end
    cannot :team_member_data, Employee do |f|
      not (team_members.include?(f) || team_team_members.include?(f))
    end
    cannot :my_team_assessment, Employee unless current.is?(:manager)
    can :assessment, Employee do |f|
      current.is?(:manager) && (team_members.map(&:id).include?(f.id) || team_team_members.map(&:id).include?(f.id))
    end
    # cannot :assessment, Employee do |f|
    #   f.is_not_assessed?
    # end
    can :pick_position, Employee do |f|
      current.employee.present? && current.position.nil?
    end
    can :select_position, Employee do |f|
      current.employee.present? && current.position.nil?
    end
    cannot :pick_position, Employee do |f|
      not current.employee.present? && current.position.nil?
    end

    cannot :select_position, Employee do |f|
      not current.employee.present? && current.position.nil?
    end
    # ---------------------------------------------------------------------------------------------

    # EmployeeVacation -------------------------------------------------------------------
    cannot :manage, EmployeeVacation
    can [:new, :create], EmployeeVacation if current.is?(:employee)
    can [:edit, :edit_vacation, :update_vacation, :update, :delete], EmployeeVacation do |f|
      employee_id == f.employee_id && f.left_at > Date.current && (f.approved? || f.pending?)
    end
    can :show, EmployeeVacation do |f|
      f.employee_id == employee_id || team_member_ids.include?(f.employee_id) || VacationApprover.where(employee_id: employee_id).exits?
    end
    can :destroy, EmployeeVacation do |f|
      employee_id == f.employee_id && f.left_at > Date.current && (f.approved? || f.pending?)
    end
    # ------------------------------------------------------------------------------------------
    # tax_salaries ------------------------------------------------------------------------
    can :manage, TaxSalary if current.is?(:hr)
    can [:partial_view_tax_types], TaxType
    # ---------------------------------------------------------------------------------------------

    # subsidy_salaries ------------------------------------------------------------------------
    can :manage, SubsidySalary if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # tax_types ------------------------------------------------------------------------
    can :manage, TaxType if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # subsidy_types ------------------------------------------------------------------------
    can :manage, SubsidyType if current.is?(:hr)
    can [:partial_view_subsidy_types], SubsidyType
    # ---------------------------------------------------------------------------------------------

    # paygrade_change_reasons ------------------------------------------------------------------------
    can :manage, PaygradeChangeReason if current.is?(:hr)
    can [:partial_view_paygrade_change_reasons], PaygradeChangeReason
    # ---------------------------------------------------------------------------------------------

    # employee_paygrades ------------------------------------------------------------------------
    can :manage, EmployeePaygrade if current.is?(:hr)
    cannot [:new, :create], EmployeePaygrade unless SalaryBoard.latest&.active?
    # ---------------------------------------------------------------------------------------------

    # employee_requests ------------------------------------------------------------------------
    request_approvers = ObjectApprover.where(object_type: RequestType.name).to_a
    cannot :manage, EmployeeRequest # if current.is?(:hr)
    can :index, EmployeeRequest if current.is?(:admin) || current.is?(:hr) || team_members.present? || team_team_members.present? || request_approvers.map(&:employee_id).include?(employee_id)
    can [:new, :create], EmployeeRequest if current.is?(:employee)
    can [:show], EmployeeRequest do |f|
      current.is?(:admin) || f.employee_id == employee_id || current.is?(:hr) || team_members.present? || team_team_members.present? || request_approvers.map(&:employee_id).include?(employee_id) #team_members.map(&:id).include?(f.employee_id) || team_team_members.map(&:id).include?(f.employee_id) || f.object_approvers.map(&:employee_id).include?(employee_id)
    end
    can [:edit, :destroy, :update], EmployeeRequest do |f|
      current.is?(:employee) && f.employee_id == employee_id
    end
    # ---------------------------------------------------------------------------------------------

    # employee_requests ------------------------------------------------------------------------
    can :manage, RequestType if current.is?(:hr)
    # -------------------------------------------------------------------------------------------

    # report_reviewers ------------------------------------------------------------------------
    can :manage, ReportReviewer if current.is?(:hr)
    can [:destroy], Report do |f|
      current.is?(:employee) && f.employee_id == employee_id
    end
    # -------------------------------------------------------------------------------------------

    # report_reviewers ------------------------------------------------------------------------
    reviewers = ReportReviewer.all.map(&:employee_id)
    cannot [:create], Report unless current.is?(:employee)
    can [:new, :create, :cancel_report, :open_report], Report if current.is?(:employee)
    can :index, Report if reviewers.include?(employee_id)
    can :show, Report do |f|
      f.employee_id == employee_id || reviewers.include?(employee_id)
    end
    # -------------------------------------------------------------------------------------------

    # object_attachments ------------------------------------------------------------------------
    can :manage, ObjectAttachment
    # -------------------------------------------------------------------------------------------

    # ObjectVideo ------------------------------------------------------------------------
    can :manage, ObjectVideo
    # -------------------------------------------------------------------------------------------

    # object_responses ------------------------------------------------------------------------
    cannot :approve, ObjectResponse
    can :approve, ObjectResponse do |f|
      responses = f.object.object_responses.sort_by{|r| r.enum_v(:kind)}.to_a
      approvers = f.object.object_approvers.to_a
      if f.approved? || employee_id == f.object.employee_id
        false
      elsif f.supervisor_supervisor? && responses.select{|r| r.supervisor? && !r.approved?}.present?
        false
      elsif f.dpe_employee? && responses.select{|r| (f.supervisor_supervisor? || r.supervisor?) && !r.approved?}.present?
        false
      elsif f.dpe_supervisor? && responses.select{|r| (f.dpe_employee? || f.supervisor_supervisor? || r.supervisor?) && !r.approved?}.present?
        false
      elsif responses.map(&:employee_id).compact.include?(employee_id) && f.employee_id != employee_id
        false
      elsif f.employee_id.present? && f.employee_id == employee_id
        true

      elsif f.dpe_employee? && approvers.select{|a| a.dpe_employee? && a.employee_id == employee_id}.present?
        true

      elsif f.dpe_supervisor? && approvers.select{|a| a.dpe_supervisor? && a.employee_id == employee_id}.present?
        true

      else
        false
      end
    end
    cannot :disaprove, ObjectResponse
    can :disaprove, ObjectResponse do |f|
      responses = f.object.object_responses.sort_by{|r| r.enum_v(:kind)}.to_a
      approvers = f.object.object_approvers.to_a
      if f.not_approved? || employee_id == f.object.employee_id
        false
      elsif f.supervisor_supervisor? && responses.select{|r| r.supervisor? && !r.approved?}.present?
        false
      elsif f.dpe_employee? && responses.select{|r| (f.supervisor_supervisor? || r.supervisor?) && !r.approved?}.present?
        false
      elsif f.dpe_supervisor? && responses.select{|r| (f.dpe_employee? || f.supervisor_supervisor? || r.supervisor?) && !r.approved?}.present?
        false
      elsif responses.map(&:employee_id).compact.include?(employee_id) && f.employee_id != employee_id
        false
      elsif f.employee_id.present? && f.employee_id == employee_id
        true

      elsif f.dpe_employee? && approvers.select{|a| a.dpe_employee? && a.employee_id == employee_id}.present?
        true

      elsif f.dpe_supervisor? && approvers.select{|a| a.dpe_supervisor? && a.employee_id == employee_id}.present?
        true

      else
        false
      end
    end
    cannot :remove, ObjectResponse
    can :remove, ObjectResponse do |f|
      if f.employee_id.nil? || f.supervisor? || f.supervisor_supervisor?
        false
      elsif employee_id == f.employee_id
        true
      else
        false
      end
    end
    # -------------------------------------------------------------------------------------------
    cannot :manage, ObjectApprover
    can [:new, :create], ObjectApprover
    # salaries ------------------------------------------------------------------------
    can :manage, Salary if current.is?(:hr)
    can [:partial_view_salary], Salary
    cannot [:new, :create, :new_salary_map, :create_salary_map], Salary unless EmployeeSalaryFamily.exists?
    cannot [:add_subsidy, :add_tax, :remove_subsidy, :remove_tax], Salary do |f|
      f.paid?
    end
    cannot :pay, Salary do |f|
      f.paid?
    end
    cannot :activate, Salary do |f|
      f.active?
    end

    # employee_work_periods ------------------------------------------------------------------------
    can :manage, EmployeeWorkPeriod if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # salary_board --------------------------------------------------------------------------------
    can :manage, SalaryBoard if current.is?(:hr)
    cannot [:new, :create, :edit, :update], SalaryBoard if RemunerationSetting.last.nil?
    # ---------------------------------------------------------------------------------------------

    # salary_grid --------------------------------------------------------------------------------
    can :manage, SalaryGrid if current.is?(:hr)
    cannot [:add_grid, :remove_grid], SalaryGrid if RemunerationSetting.last.nil?
    cannot [:remove_grid], SalaryGrid if (SalaryGrid.latest.maximum(:number) || 0) <= 1
    # ---------------------------------------------------------------------------------------------

    # SalaryCategory --------------------------------------------------------------------------------
    can :manage, SalaryCategory if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # SalaryArea --------------------------------------------------------------------------------
    can :manage, SalaryArea if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # SalaryLayer --------------------------------------------------------------------------------
    can :manage, SalaryLayer if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # SalaryGroup --------------------------------------------------------------------------------
    can :manage, SalaryGroup if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # SalaryGroup --------------------------------------------------------------------------------
    can :manage, SalaryFamily if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # SalaryGroup --------------------------------------------------------------------------------
    can :manage, EmployeeSalaryFamily if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # remuneration_setting ------------------------------------------------------------------------
    can :manage, RemunerationSetting if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # EmployeeGoal  -------------------------------------------------------------------------------
    can :manage, EmployeeGoal if current.is?(:hr)
    can [:partial_view_show], EmployeeGoal
    can :update, EmployeeGoal do |f|
      owns_employee_goal = current.is?(:employee) && f.employee_id == current&.employee&.id && !f.closed?
      supervises_the_employee = current.is?(:manager) && team_positions.map(&:id).include?(f.position_id)
      supervises_the_employee_supervisor = current.is?(:manager) && team_team_positions.map(&:id).include?(f.position_id)
      owns_employee_goal || supervises_the_employee || supervises_the_employee_supervisor
    end
    can :show, EmployeeGoal do |f|
      owns_employee_goal = current.is?(:employee) && f.employee_id == current&.employee&.id
      supervises_the_employee = current.is?(:manager) && team_positions.map(&:id).include?(f.position_id)
      supervises_the_employee_supervisor = current.is?(:manager) && team_team_positions.map(&:id).include?(f.position_id)
      owns_employee_goal || supervises_the_employee || supervises_the_employee_supervisor
    end
    can :edit, EmployeeGoal do |f|
      owns_employee_goal = current.is?(:employee) && f.employee_id == current&.employee&.id
      supervises_the_employee = current.is?(:manager) && team_positions.map(&:id).include?(f.position_id)
      supervises_the_employee_supervisor = current.is?(:manager) && team_team_positions.map(&:id).include?(f.position_id)

      owns_employee_goal || supervises_the_employee || supervises_the_employee_supervisor
    end
    cannot :edit, EmployeeGoal do |f|
      f.closed?
    end
    cannot :update, EmployeeGoal do |f|
      f.closed?
    end
    # ---------------------------------------------------------------------------------------------

    # EmployeeGoalActivity  -------------------------------------------------------------------------------
    can :manage, EmployeeGoalActivity
    cannot [:update, :destroy], EmployeeGoalActivity
    # ---------------------------------------------------------------------------------------------

    # EmployeeMessages -------------------------------------------------------------------------------------
    can [:show, :index], EmployeeMessage, employee: {id: employee_id}
    cannot [:index, :show], EmployeeMessage unless current.is?(:employee)
    # TODO, Review permissions
    # ----------------------------------------------------------------------------------------------

    # EmployeeRegime ------------------------------------------------------------------------
    can :manage, EmployeeRegime if current.is?(:hr)
    # -------------------------------------------------------------------------------------------

    # Department ----------------------------------------------------------------------------------
    can :manage, Function if current.is?(:hr, :admin)
    can :manage, FunctionSetting if current.is?(:hr, :admin)
    can :manage, FunctionSkill if current.is?(:hr)
    can [:edit, :update], EmployeeSkill do |f|
      team_members.map(&:id).include?(f.employee_id)
    end
    can [:edit, :update], EmployeeSkill do |f|
      f.employee_id == employee_id
    end
    can [:update, :edit], EmployeeSkill if current.is?(:hr, :manager)
    can :manage, Skill if current.is?(:hr)
    can :manage, FunctionDeslocationRegime if current.is?(:hr)
    can :manage, FunctionContractType if current.is?(:hr)
    can :manage, FunctionArea if current.is?(:hr)
    can :manage, FunctionSubsidy if current.is?(:hr)
    can :manage, FunctionAutonomyLevel if current.is?(:hr)
    # ---------------------------------------------------------------------------------------------

    # Messages -------------------------------------------------------------------------------------
    can :manage, Message if current.is?(:hr)
    cannot [:edit, :update], Message do |f|
      f.sent?
    end
    # ----------------------------------------------------------------------------------------------

    # Position -------------------------------------------------------------------------------------
    can :manage, TimeSetting if current.is?(:hr)
    # ----------------------------------------------------------------------------------------------

    # Position -------------------------------------------------------------------------------------
    can :manage, Pelouro if current.is?(:hr)
    # ----------------------------------------------------------------------------------------------

    # Position -------------------------------------------------------------------------------------
    can :manage, Position if current.is?(:hr)
    cannot :my_orgchart, Position unless current.is?(:employee) && current.position.present? ##
    cannot :my_team_orgchart, Position unless current.is?(:manager) ##
    can :my_orgchart, Position if current.is?(:employee) && current.position.present? ##
    can :my_team_orgchart, Position if current.is?(:manager) ##
    # ----------------------------------------------------------------------------------------------

    # Vacancy -------------------------------------------------------------------------------------
    can :manage, Vacancy if current.is?(:hr)
    can :index, Vacancy
    can :show, Vacancy
    # ----------------------------------------------------------------------------------------------

    # VacationApprover -----------------------------------------------------------------------------
    can :manage, VacationApprover if current.is?(:hr)
    # ----------------------------------------------------------------------------------------------

    # EmployeeVacationResponse ---------------------------------------------------------------------
    cannot :manage, EmployeeVacationResponse
    can :update, EmployeeVacationResponse do |f|
      approvers = VacationApprover.all.map(&:employee_id)
      responses = f.employee_vacation.employee_vacation_responses.map(&:status).uniq
      if (responses.size == 1 && (responses.includes?('approved', 'not_approved'))) || f.employee_vacation.employee_id == employee_id
        false
      elsif f.hr? && approvers.include?(employee_id) && f.employee_vacation.employee_vacation_responses.supervisor.where(employee_id: employee_id).none?
        true
      elsif f.supervisor? && team_members.map(&:id).include?(f.employee_vacation.employee_id)
        true
      end
    end
    # ----------------------------------------------------------------------------------------------

    # Result -------------------------------------------------------------------------------------
    can [:new, :create], Result if current.is?(:employee)
    # ----------------------------------------------------------------------------------------------

    # Goal -------------------------------------------------------------------------------------
    can :manage, Goal if current.is?(:hr)
    can :new, Goal if current.is?(:manager)
    can :create, Goal if current.is?(:manager) ##
    # ----------------------------------------------------------------------------------------------

    # User -------------------------------------------------------------------------------------
    can :index, User if current.is?(:hr)
    can :reset_password, User if current.is?(:hr)
    can :generate_password, User if current.is?(:hr)
    cannot :reset_password, User do |f|
      f.email.nil?
    end
    cannot :generate_password, User do |f|
      f.employee_number.nil?
    end
    # ----------------------------------------------------------------------------------------------
  end
end
