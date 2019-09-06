module Nextsgad
  class AssessmentsController < NextSgad::AssessmentsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Assessment
    before_action :set_assessment, only: [:show, :edit, :update, :destroy,
                                          :new_goal, :create_goal,
                                          :assessments_map, :activate, :close, :deactivate, :draft, :new_skill,
                                          :create_skill, :new_objective, :create_objective, :new_skills_from_last_year, :create_skills_from_last_year]

    # GET /assessments
    def index
      @assessment = Assessment.new(cancel_url: assessments_url)
      @assessments = Assessment.all.year(params[:year]).status(params[:status])

      @name_assessments = Assessment.all.map {|y| [y.year, y.year] if y.year.present?}
    end

    def old_assessments_export
      @assessments = Assessment.old_assessments_export_for_year(params[:year])
      respond_to do |format|
        format.xls
      end
      return
    end

    def assessments_map
      @total_employees_assessments = @assessment.employees_assessments.size
      if @assessment.present?
        @assessment.cancel_and_redirect_url_to(assessments_map_url(@assessment))
        @employees_assessments = @assessment.employees_assessments.index_by(&:employee_id)
        @goals = @assessment.goals
        @employees = Employee
                         .where(id: @assessment.employees_assessments.map(&:employee_id))
                         .none_if_blank(params, :organic_unit_id, :function_id, :position_id, :paygrade, :level, :employee_id)
                         .organic_unit_id(params[:organic_unit_id])
                         .function_id(params[:function_id])
                         .position_id(params[:position_id])
                         .employee_id(params[:employee_id])
                         .paygrade(params[:paygrade])
                         .level(params[:level])

        @all_employees_ids = Employee.all.map(&:id)

        @completion_percentage_self = @assessment.employee_goals.where(employee_id: @all_employees_ids).assessment_completion_percentage_self()
        @completion_percentage_supervisor = @assessment.employee_goals.where(employee_id: @all_employees_ids).assessment_completion_percentage_supervisor()
        @completion_percentage_final = @assessment.employee_goals.where(employee_id: @all_employees_ids).assessment_completion_percentage_final()


        @all_self_assessment_status0 = @assessment.employees_assessments.where(self_assessment_status: 0).size
        @all_self_assessment_status1 = @assessment.employees_assessments.where(self_assessment_status: 1).size
        @all_self_assessment_status2 = @assessment.employees_assessments.where(self_assessment_status: 2).size

        @all_supervisor_assessment_status0 = @assessment.employees_assessments.where(supervisor_assessment_status: 0).size
        @all_supervisor_assessment_status1 = @assessment.employees_assessments.where(supervisor_assessment_status: 1).size
        @all_supervisor_assessment_status2 = @assessment.employees_assessments.where(supervisor_assessment_status: 2).size

        @all_final_assessment_status0 = @assessment.employees_assessments.where(final_assessment_status: 0).size
        @all_final_assessment_status1 = @assessment.employees_assessments.where(final_assessment_status: 1).size
        @all_final_assessment_status2 = @assessment.employees_assessments.where(final_assessment_status: 2).size

        @employees_assessments_index_by_employee_id = @assessment.employees_assessments.index_by(&:id)

        @comments_by_employee = @assessment.employee_goals.where.not(employee_note: [nil, '']).group_by(&:employee_id).map{|employee_id, employee_goals| [employee_id, {comments_number: employee_goals.size, reports_number: employee_goals.select(&:report).size}]}.to_h

        #@o = (@goals + @employee_goals).group_by {|d| [d.class.name, d.id]}
        @objective = Goal.new(assessment_id: @assessment.id, goal_type: :objective, redirect_url: assessments_map_path(@assessment.id), cancel_url: assessments_map_path(@assessment.id))
        @skill = Goal.new(assessment_id: @assessment.id, goal_type: :skill, redirect_url: assessments_map_path(@assessment.id), cancel_url: assessments_map_path(@assessment.id))

        respond_to do |format|
          format.html
          format.xls
          format.pdf do
            send_data AssessmentsMap.new(@employees, @employees_assessments, view_context).render, filename: "colaboradores.pdf", type: 'application/pdf', disposition: 'inline'
          end
        end


      end
    end

    # GET /assessments/1
    def show
      @goal = Goal.new(assessment_id: @assessment.id)
      @objective = Goal.new(assessment_id: @assessment.id, goal_type: :objective)
      @skill = Goal.new(assessment_id: @assessment.id, goal_type: :skill)
      @assessment.cancel_and_redirect_url_to(assessment_url(@assessment))
    end

    # GET /assessments/new
    def new
      @assessment = Assessment.new
    end

    # GET /assessments/1/edit
    def edit
    end

    # POST /assessments
    def create
      @assessment = Assessment.new(assessment_params)

      if @assessment.save
        redirect_to @assessment.redirect_url || assessments_map_url(@assessment), notice: t('register_was_successfully_created')
      else
        render :new
      end
    end

    # PATCH/PUT /assessments/1
    def update
      if @assessment.update(assessment_params)
        redirect_to @assessment.redirect_url || assessments_map_url(@assessment), notice: t('register_was_successfully_updated')
      else
        render :edit
      end
    end

    def new_goal
      @goal = Goal.new
    end

    def create_goal
      @goal = Goal.new(goal_params)
      @goal.assessment_id = @assessment.id

      if @goal.save
        redirect_to @goal.redirect_url || assessments_map_url(@assessment), notice: t('register_was_successfully_created')
      else
        render :new_goal
      end
    end

    def new_skill
      @goal = Goal.new(goal_type: :skill)
    end

    def create_skill
      @skill = Goal.new(goal_params)
      @skill.assessment_id = @assessment.id
      @skill.goal_type = :skill
      if @skill.save
        redirect_to @skill.redirect_url || assessments_map_url(@assessment), notice: t('register_was_successfully_created')
      else
        render :new_skill
      end
    end

    def new_objective
      @objective = Goal.new(goal_type: :objective)
    end

    def create_objective
      @objective = Goal.new(goal_params)
      @objective.assessment_id = @assessment.id
      @objective.goal_type = :objective
      if @objective.save
        redirect_to @objective.redirect_url || assessments_map_url(@assessment), notice: t('register_was_successfully_created')
      else
        render :new_objective
      end
    end

    # DELETE /assessments/1
    def destroy
      @assessment.destroy
      redirect_to @assessment.redirect_url || assessments_url, notice: t('register_was_successfully_destroyed')
    end

    def activate
      @assessment.active!
      @assessment.goals.update_all(status: @assessment.status)
      @assessment.employee_goals.update_all(status: @assessment.status)
      redirect_to redirect_url || assessments_map_url(@assessment)
    end

    def close
      @assessment.closed!
      @assessment.goals.update_all(status: @assessment.status)
      @assessment.employee_goals.update_all(status: @assessment.status)
      redirect_to redirect_url || assessments_map_url(@assessment)
    end

    def deactivate
      @assessment.inactive!
      @assessment.goals.update_all(status: @assessment.status)
      @assessment.employee_goals.update_all(status: @assessment.status)
      redirect_to redirect_url || assessments_map_url(@assessment)
    end

    def draft
      @assessment.draft!
      @assessment.goals.update_all(status: @assessment.status)
      @assessment.employee_goals.update_all(status: @assessment.status)
      redirect_to redirect_url || assessments_map_url(@assessment)
    end

    def new_skills_from_last_year
      respond_to do |format|
        @skills = @assessment.dup_last_year_skills
        if @skills.empty?
          format.html
          format.js
        else
          flash[:error] = 'Não tem competências para carregar'
          format.html {redirect_to redirect_url || assessments_map_url(@assessment)}
          format.js
        end
      end
    end

    def create_skills_from_last_year
      @skills = Goal.create(skills_params) do |goal|
        goal.assessment_id = @assessment.id
      end
      @skills = @skills.map {|f| f if f.id.nil? && f.name.present?}.compact
      @upload = Upload.new(type: 'skills')
      if @skills.size <= 0
        flash[:notice] = 'created'.ts
        redirect_to redirect_url || assessments_map_url(@assessment)
      else
        render :new_skills_from_last_year
      end
    end

    def reports
      unless params[:format] == 'pdf'


        @assessment = Assessment.get_assessment(params[:alt_year])
        return unless @assessment.present?

        @current_year = params[:alt_year] ||= params[:year]

        unless @current_year == '2018'
          @departaments_filter = Department.all.map {|p| ["#{p.number} - #{p.name}", p.id]}
          @departaments_filter.unshift([t(".company_average"), 0])
          if params[:alt_year].present?
            params[:year] = params[:alt_year]
          elsif params[:year].present?
            params[:alt_year] = params[:year]
          end
          @page_name = 'Relatórios'
          employee_goals = @assessment.employee_goals.order(updated_at: :asc).map {|a| a.updated_at.to_date}.uniq
          if employee_goals.last.present?
            dates_array = ((employee_goals.first..employee_goals.last) || []).map {|g| [l(g, format: :short_month_and_year), 0]}.to_h
          else
            dates_array = [].to_h
          end
          @employee_goals_by_date = dates_array.merge(@assessment.employee_goals.order(updated_at: :asc).group_by {|g| l(g.updated_at, format: :short_month_and_year)}.map {|date, employee_goals| [date, employee_goals.map(&:employee_id).uniq.size]}.to_h)
          @departments = Department.all.order(name: :asc)

          @departments_by_id = Department.all.index_by(&:id)

          @positions_by_employee_id = Position.all.index_by(&:efective_id)
          @employees_by_id = Employee.all.index_by(&:id)
          @employees_assessments = @assessment.employees_assessments
                                       .self_assessment_status(params[:self_assessment_status])
                                       .supervisor_assessment_status(params[:supervisor_assessment_status])
                                       .final_assessment_status(params[:final_assessment_status])
          @employee_goals = @assessment.employee_goals.skill
          @employees_assessments_index_by_employee_id = @employees_assessments.index_by(&:id)

          @assessment_by_dep = @departments.employees_assessments_by_dep(@assessment.employees_assessments).map do |dep, assessments|
            ass_by_status    = assessments.group_by(&:status)
            in_progress      = ass_by_status[:in_progress]&.size || 0
            pending          = ass_by_status[:pending]&.size || 0
            completed        = ass_by_status[:completed]&.size || 0
            total            = in_progress + pending + completed
            if total == 0
              completed   = 0
              pending     = 0
              in_progress = 0
            else
              pending     = ((pending.to_f/total)*100).round(2)
              completed   = ((completed.to_f/total)*100).round(2)
              in_progress = ((in_progress.to_f/total)*100).round(2)
            end
            [dep, completed, pending, in_progress, total]
          end

          # Data for line_chart
          @data = {
            labels: @employee_goals_by_date.keys,
            datasets: [
              {
                label: t('.skill_reports'),
                backgroundColor: "rgba(120,220,120,0)",
                borderColor: "rgba(120,220,120,1)",
                data: @employee_goals_by_date.values
              }
            ]
          }

          # optios for bar chart
          @options = {
            id: 'employee_goals_by_date_chart',
            height: '80',
            elements: {
              line: {tension: 0}
            },
            scales: {

              yAxes: [
                {
                  ticks: {
                    beginAtZero: true,
                    fontSize: 9,
                    #max: 100,
                    min: 0,
                    #stepSize: 25
                  }
                }
              ]
            }
          }


          # data for horizontal bar chart
          @data_2 = {
              labels: @assessment_by_dep.map {|dep, completed, pending, in_progress, total| name = dep&.name&.truncate(20) || t('n/a'); "#{name} (#{total})"},
              datasets: [
                  {
                      data: @assessment_by_dep.map {|dep, completed, pending, in_progress, total| pending.round(2)},
                      backgroundColor: 'rgba(200, 12, 12, 0.3)',
                      borderColor: 'rgba(200, 12, 12, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  },
                  {
                      data: @assessment_by_dep.map {|dep, completed, pending, in_progress, total| in_progress.round(2)},
                      backgroundColor: 'rgba(250, 176, 51, 0.3)',
                      borderColor: 'rgba(250, 176, 51, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  },
                  {
                      data: @assessment_by_dep.map {|dep, completed, pending, in_progress, total| completed.round(2)},
                      backgroundColor: 'rgba(99, 200, 99, 0.3)',
                      borderColor: 'rgba(99, 200, 99, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  }]
          }

          # options for horizontal bar chart
          @options_2 = {
              id: 'completion_by_dep_chart',
              height: ((@departments.size + 1)*22).to_s,
              maintainAspectRatio: false,
              chart_type: 'horizontal-bar',
              scales: {
                xAxes: [{
                  ticks: {
                    beginAtZero: true,
                    fontSize: 8,
                    #max: 100,
                    min: 0,
                    stepSize: 10
                  },
                  scaleLabel: {
                      display: false
                  },
                  gridLines: {
                  },
                  stacked: true
                }],
                yAxes: [{
                  barThickness: 10,
                  ticks: {
                    fontSize: 7
                  },
                  stacked: true,
                  id: 'y-axis'
                }]
              },
              legend: {display: false},
              title: {
                display: true,
                text: t('.conclusion_percentage')
              },
              xAxes: [{
                display: true,
                ticks: {
                  beginAtZero: true,
                  steps: 10,
                  stepValue: 10,
                  max: 100
                },
                scaleLabel: {
                  display: true,
                  labelString: t('departments')
                },
                stacked: true
              }]
          }

          @employee_goals.group_by {|f| f.goal_id}.map {|k, employee_goals| employee_goals}

          @employee_goals_by_goal_dep = @employee_goals.department_id(params[:employee_organic_unit_id]&.last.to_i).group_by(&:id)

          employee_goals_by_dep = @employee_goals.group_by {|f| @departments_by_id[@positions_by_employee_id[f.employee_id]&.department_id]}

          @employee_by_dep_value_and_toal_employees = employee_goals_by_dep.map do |dep, employee_goals_f|
            employee_goals = employee_goals_f.group_by {|f| f.goal_id}.map do |goal_id, employee_goals_g|
              average = ((employee_goals_g.sum(&:final_assessment))/employee_goals_g.size).round(2)
              total_employees = employee_goals_g.map(&:employee_id).uniq.size
              [employee_goals_g.first.name, average, total_employees, goal_id]
            end
            [dep, employee_goals]
          end
          @employee_by_dep_value_and_toal_employees = @employee_by_dep_value_and_toal_employees.to_h

          @employee_goals_by_goal = @employee_goals.group_by(&:goal_id).map do |goal_id, employee_goals_g|
            average = ((employee_goals_g.sum(&:final_assessment))/employee_goals_g.size).round(2)
            total_employees = employee_goals_g.map(&:employee_id).uniq.size
            [employee_goals_g.first.name, average, total_employees]
          end
        else
          # alterações para o ano de 2018 (exception)

          @employees = Employee.where(can_be_assessed: true)

          @employees_chefias   = Employee.includes(efective_position: :positions).select{|x| x.efective_position && x.efective_position.positions.size > 0}.size
          @employees_n_chefias = Employee.includes(efective_position: :positions).select{|x| x.efective_position && x.efective_position.positions.size == 0}.size
          @organic_units = OrganicUnit.all.map { |e| [e.name, e.id] }
          employee_skills_date          = EmployeeSkill.includes(:employee).where('next_sgad_employees.can_be_assessed' => true).distinct.pluck('DATE(employee_skills.updated_at)')
          if employee_skills_date.last.present?
            dates_array = ((employee_skills_date.first..employee_skills_date.last) || []).map {|g| [l(g, format: :short_month_and_year), 0]}.to_h
          else
            dates_array = [].to_h
          end
          @employee_skills_by_date = dates_array.merge(EmployeeSkill.includes(:employee).where('next_sgad_employees.can_be_assessed' => true).group_by {|g| l(g.updated_at, format: :short_month_and_year)}.map {|date, employee_goals| [date, employee_goals.map(&:employee_id).uniq.size]}.to_h)

          #[dep name, dep ID, dep employee quant, completed, pending, in_progress]
          @assessment_by_dep = Skill.skills_can_be_assessed_employees_assessments

          # Data for line_chart
          @data = {
            labels: @employee_skills_by_date.keys,
            datasets: [
              {
                label: t('.skill_reports'),
                backgroundColor: "rgba(120,220,120,0)",
                borderColor: "rgba(120,220,120,1)",
                data: @employee_skills_by_date.values
              }
            ]
          }

          # optios for bar chart
          @options = {
            id: 'employee_goals_by_date_chart',
            height: '80',
            elements: {
              line: {tension: 0}
            },
            scales: {

              yAxes: [
                {
                  ticks: {
                    beginAtZero: true,
                    fontSize: 9,
                    #max: 100,
                    min: 0,
                    #stepSize: 25
                  }
                }
              ]
            }
          }

          data_name = []
          data_pending = []
          data_in_progress = []
          data_completed = []

          @assessment_by_dep.map do |dep_name, dep_id, total, completed, in_progress, pending|
            data_name << "#{dep_name.first(3)}. #{dep_name.split(' ')[1..-1]&.join(' ')}"&.truncate(20) || t('n/a')
            data_in_progress << in_progress
            data_completed << completed
            # data_pending << pending
            data_pending << 100 - (in_progress + completed)
          end
          # data for horizontal bar chart
          #@assessment_by_dep = result_query.map { |e| e[0], e[1], e[2], e[3], e[4], e[5]}
          @data_2 = {
              labels: data_name,
              datasets: [
                  {
                      data: data_pending,
                      backgroundColor: 'rgba(200, 12, 12, 0.3)',
                      borderColor: 'rgba(200, 12, 12, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  },
                  {
                      data: data_in_progress,
                      backgroundColor: 'rgba(250, 176, 51, 0.3)',
                      borderColor: 'rgba(250, 176, 51, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  },
                  {
                      data: data_completed,
                      backgroundColor: 'rgba(99, 200, 99, 0.3)',
                      borderColor: 'rgba(99, 200, 99, 0.7)',
                      borderWidth: '0',
                      yAxisID: 'y-axis'
                  }]
          }

          # options for horizontal bar chart
          @options_2 = {
              id: 'completion_by_dep_chart',
              height: ((@assessment_by_dep.size + 1)*22).to_s,
              maintainAspectRatio: false,
              chart_type: 'horizontal-bar',
              scales: {
                xAxes: [{
                  ticks: {
                    beginAtZero: true,
                    fontSize: 8,
                    #max: 100,
                    min: 0,
                    stepSize: 10
                  },
                  scaleLabel: {
                      display: false
                  },
                  gridLines: {
                  },
                  stacked: true
                }],
                yAxes: [{
                  barThickness: 10,
                  ticks: {
                    fontSize: 7
                  },
                  stacked: true,
                  id: 'y-axis'
                }]
              },
              legend: {display: false},
              title: {
                display: true,
                text: t('.conclusion_percentage')
              },
              xAxes: [{
                display: true,
                ticks: {
                  beginAtZero: true,
                  steps: 10,
                  stepValue: 10,
                  max: 100
                },
                scaleLabel: {
                  display: true,
                  labelString: t('departments')
                },
                stacked: true
              }]
          }

          # ["9946", "MANUEL JOAQUIM", "BALCAO DO MICROCREDITO", 3, 1, 1]
          @employees_assessments_progress   = Skill.employees_with_employee_assessments_progress
          @degree_of_concretization         = Skill.degree_of_concretization
          @nivel_of_concretization          = Skill.nivel_of_concretization
          @skill_organic_unit_comparison    = Skill.skill_organic_unit_comparison
          @final_classification             = Skill.final_classification
          @average_by_fuction               = Skill.average_by_fuction
          @average_by_type_assessment       = Skill.average_by_type_assessment
          if params[:employee_organic_unit_id].present?
            @department_name                    = OrganicUnit.find(params[:employee_organic_unit_id]).name
            @employee_skills_by_organic_unit    = Skill.skill_assessed_in_organic_unit(params[:employee_organic_unit_id])
            @organic_unit_final_classification  = Skill.organic_unit_final_classification(params[:employee_organic_unit_id])
            @organic_unit_degree_of_concretization = Skill.organic_unit_degree_of_concretization(params[:employee_organic_unit_id])
            @total_unit_degree_of_concretization   = @organic_unit_degree_of_concretization[0] + @organic_unit_degree_of_concretization[1] + @organic_unit_degree_of_concretization[2]
          end
        end

      end


      respond_to do |format|
        format.html
        format.xls
        format.pdf do
          send_data PdfReports.new(view_context, params[:charts].permit!).render, filename: "reports.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end

    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def assessment_params
      params.require(:assessment).permit(:year, :status, :skills_percentage, :objectives_percentage,
                                         :attendance_percentage, :number_of_four_hours_delay_to_absence, :number_of_three_hours_delay_to_absence,
                                         :number_of_two_hours_delay_to_absence, :number_of_one_hour_delay_to_absence,
                                         :max_absences_for_five, :max_absences_for_four, :max_absences_for_three, :max_absences_for_two, :max_absences_for_one, :cancel_url, :redirect_url)
    end

    # Only allow a trusted parameter "white list" through.
    def goal_params
      params.require(:goal).permit(:name, :status, :nature, :unit, :target, :cancel_url, :redirect_url, {position_ids: [], function_ids: []}, :redirect_url, :cancel_url, :for_everyone)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skills_params
      params.require(:goal).map {|m| m.permit(:name, :status, :nature, :unit, :target, :cancel_url, :redirect_url, {function_ids: []}, :redirect_url, :cancel_url, :for_everyone)}
    end
  end
end
