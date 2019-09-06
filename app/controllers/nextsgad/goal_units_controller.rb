module Nextsgad
  class GoalUnitsController < NextSgad::GoalUnitsController
    before_action :authenticate_account!
    load_and_authorize_resource class: GoalUnit
    layout :resolve_layout
    before_action :set_goal_unit, only: [:show, :edit, :update, :destroy]

    # GET /goal_units
    def index
      @goal_units = GoalUnit.all
    end

    # GET /goal_units/1
    def show
    end

    # GET /goal_units/new
    def new
      @goal_unit = GoalUnit.new
    end

    # GET /goal_units/1/edit
    def edit
    end

    # POST /goal_units
    def create
      @goal_unit = GoalUnit.new(goal_unit_params)

      if @goal_unit.save
        redirect_to latest_assessment_setting_url(active_tab: :tab_goal_settings), notice: 'Goal unit was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /goal_units/1
    def update
      if @goal_unit.update(goal_unit_params)
        redirect_to latest_assessment_setting_url(active_tab: :tab_goal_settings), notice: 'Goal unit was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /goal_units/1
    def destroy
      @goal_unit.destroy
      redirect_to latest_assessment_setting_url(active_tab: :tab_goal_settings), notice: 'Goal unit was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_goal_unit
        @goal_unit = GoalUnit.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def goal_unit_params
        params.require(:goal_unit).permit(:singular_name, :plural_name, :status)
      end
  end
end
