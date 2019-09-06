module Nextsgad
  class GoalsController < NextSgad::GoalsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Goal
    layout :resolve_layout
    before_action :set_goal, only: [:show, :edit, :update, :destroy]

    # GET /goals
    def index
      @goal = Goal.new

      @goals = Goal.all.includes(:assessment)
                   .goal_type(params[:goal_type])
                   .assessment_id(params[:assessment_id])
                   #.paginate(page: params[:page], per_page: 10)
      @goal = Goal.new
      # @objective = Goal.new(assessment_id: @assessment.id, goal_type: :objective, redirect_url: goals_path(), cancel_url: goals_path())
      # @skill = Goal.new(assessment_id: @assessment.id, goal_type: :skill, redirect_url: goals_path(), cancel_url: goals_path())
      respond_to do |format|
        format.html
        format.xls
        format.pdf do
          send_data Goals.new(@goals, params, current, view_context).render, filename: "#{t :goals}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end
    end

    # GET /goals/1
    def show
      @goal.cancel_and_redirect_url_to(goal_url(@goal))
    end

    # GET /goals/new
    def new
      hash = goal_params rescue {}
      @goal = Goal.new(hash)
    end

    # GET /goals/1/edit
    def edit
    end

    # POST /goals
    def create
      @goal = Goal.new(goal_params)
      if @goal.save
        redirect_to @goal.redirect_url || assessments_map_url(@goal.assessment), notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /goals/1
    def update
      if @goal.update(goal_params)
        redirect_to @goal.redirect_url || assessments_map_url(@goal.assessment), notice: 'register_was_successfully_updated'.ts
      else
        render :edit
      end
    end

    # DELETE /goals/1
    def destroy
      @goal.destroy
      redirect_to goals_url, notice: 'register_was_successfully_destroyed'.ts
    end

    def reload
      Goal.all.each(&:create_employee_goals)
      redirect_to goals_url, notice: t('register_was_successfully_updated')
    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_goal
        @goal = Goal.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def goal_params
        params.require(:goal).permit(:name, :goal_type, :status, :nature, :target, :assessment_id, :for_everyone, :period, :cancel_url, :redirect_url, :for_a_single_employee, {function_ids: [], position_ids: []})
      end
  end
end
