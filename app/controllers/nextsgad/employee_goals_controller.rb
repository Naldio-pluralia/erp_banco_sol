module Nextsgad
  class EmployeeGoalsController < NextSgad::EmployeeGoalsController
    before_action :authenticate_account!
    load_and_authorize_resource class: EmployeeGoal
    layout :resolve_layout
    before_action :set_employee_goal, only: [:show, :edit, :update, :destroy, :activate, :close, :deactivate, :draft, :partial_view_show]

    # GET /employee_goals
    def index
      @employee_goal = EmployeeGoal.new
      @employee_goals = EmployeeGoal.all
    end

    # GET /employee_goals/1
    def show
    end

    # GET /employee_goals/new
    def new
      @employee_goal = EmployeeGoal.new
    end

    # GET /employee_goals/1/edit
    def edit
      @employee = @employee_goal.employee
    end

    # POST /employee_goals
    def create
      @employee_goal = EmployeeGoal.new(employee_goal_params)

      if @employee_goal.save
        redirect_to @employee_goal.goto_redirect_url_or(team_member_data_url(@employee_goal.employee)), notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /employee_goals/1
    def update
      @employee = @employee_goal.employee
      before = @employee_goal.dup
      respond_to do |format|
        if @employee_goal.update(employee_goal_params)
          after = @employee_goal
          descriptions = []

          unless before.employee_note.eql?(after.employee_note)
            descriptions << {description: t(:changed_employee_note_to_x, x: after.employee_note)}
          end

          unless before.supervisor_note.eql?(after.supervisor_note)
            descriptions << {description: t(:changed_supervisor_note_to_x, x: after.supervisor_note)}
          end

          unless before.supervisor_supervisor_note.eql?(after.supervisor_supervisor_note)
            descriptions << {description: t(:changed_supervisor_supervisor_note_to_x, x: after.supervisor_supervisor_note)}
          end

          unless before.self_assessment.eql?(after.self_assessment)
            descriptions << {description: t(:changed_self_assessment_to_x, x: after.self_assessment.trim_decimal)}
          end

          unless before.supervisor_assessment.eql?(after.supervisor_assessment)
            descriptions << {description: t(:changed_supervisor_assessment_to_x, x: after.supervisor_assessment.trim_decimal)}
          end

          unless before.final_assessment.eql?(after.final_assessment)
            descriptions << {description: t(:changed_final_assessment_to_x, x: after.final_assessment.trim_decimal)}
          end
          if descriptions.present?
            EmployeeGoalActivity.create(descriptions) do |activity|
              activity.employee_goal_id = @employee_goal.id
              activity.creator = current_account
            end
          end

          format.html { redirect_to @employee_goal.goto_redirect_url_or(@employee_goal.employee_id.eql?(current.employee&.id) ? my_data_url : team_member_data_url(@employee_goal.employee)), notice: 'register_was_successfully_created'.ts }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @employee_goal.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /employee_goals/1
    def destroy
      @employee_goal.destroy
      redirect_to employee_goals_url, notice: 'register_was_successfully_destroyed'.ts
    end

    def activate
      @employee_goal.active!
      redirect_to redirect_url || @employee_goal
    end

    def close
      @employee_goal.closed!
      redirect_to redirect_url || @employee_goal
    end

    def deactivate
      @employee_goal.inactive!
      redirect_to redirect_url || @employee_goal
    end

    def draft
      @employee_goal.draft!
      redirect_to redirect_url || @employee_goal
    end

    def change_status_employee_goal
      @employee_goal = EmployeeGoal.includes(:goal, :results).find(params[:id])
      @employee_goal.update(report: !@employee_goal.report)
    end

    def partial_view_show
      @employee_goal = EmployeeGoal.includes(:results, :goal, {employee: {efective_position: [:department, :function]}}).find(params[:id])
      @result = Result.new(employee_goal_id: @employee_goal.id)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_employee_goal
        @employee_goal = EmployeeGoal.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def employee_goal_params
        params.require(:employee_goal).permit(:self_assessment, :supervisor_assessment, :final_assessment, :status, :assessment_id, :employee_note, :supervisor_note, :supervisor_supervisor_note, :amount)
      end
  end
end
