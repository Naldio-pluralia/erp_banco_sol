module Nextsgad
  class EmployeeGoalActivitiesController < NextSgad::EmployeeGoalActivitiesController
    before_action :authenticate_account!
    load_and_authorize_resource class: EmployeeGoalActivity
    layout :resolve_layout
    before_action :set_employee_goal_activity, only: [:show, :edit, :update, :destroy]

    # GET /employee_goal_activities
    def index
      @employee_goal_activities = EmployeeGoalActivity.all
    end

    # GET /employee_goal_activities/1
    def show
    end

    # GET /employee_goal_activities/new
    def new
      @employee_goal_activity = EmployeeGoalActivity.new
    end

    # GET /employee_goal_activities/1/edit
    def edit
    end

    # POST /employee_goal_activities
    def create
      @employee_goal_activity = EmployeeGoalActivity.new(employee_goal_activity_params)
      @employee_goal_activity.creator = current_account

      respond_to do |format|
        if @employee_goal_activity.save
          format.html { redirect_to employee_goal_activities_url, notice: 'register_was_successfully_created'.ts }
          format.js

        else
          format.html { render :new }
          format.js
        end
      end
    end

    # PATCH/PUT /employee_goal_activities/1
    def update
      if @employee_goal_activity.update(employee_goal_activity_params)
        redirect_to @employee_goal_activity, notice: 'Employee goal activity was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /employee_goal_activities/1
    def destroy
      @employee_goal_activity.destroy
      redirect_to employee_goal_activities_url, notice: 'Employee goal activity was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_employee_goal_activity
        @employee_goal_activity = EmployeeGoalActivity.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def employee_goal_activity_params
        params.require(:employee_goal_activity).permit(:description, :employee_goal_id, :creator_id, :creator_type, :attachment)
      end
  end
end
