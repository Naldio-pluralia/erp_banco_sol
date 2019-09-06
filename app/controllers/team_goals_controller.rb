class TeamGoalsController < ApplicationController
  before_action :set_team_goal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /team_goals
  def index
    @team_goals = TeamGoal.all
    @team_goal = TeamGoal.new
    @team_goal.cancel_and_redirect_url_to(team_goals_url)
    respond_to do |f|
      f.html
      f.json { render json: @team_goals.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /team_goals/1
  def show
    @team_goal.cancel_and_redirect_url_to(team_goal_url(@team_goal))
    respond_to do |f|
      f.html
      f.json { render json: @team_goal.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /team_goals/new
  def new
    @team_goal = TeamGoal.new
    @team_goal.cancel_url = team_goals_url
    respond_to do |f|
      f.html
      f.json { render json: @team_goal.as_json}
      f.js
    end
  end

  # GET /team_goals/1/edit
  def edit
    @team_goal.cancel_and_redirect_url_to(team_goal_url(@team_goal))
    respond_to do |f|
      f.html
      f.json { render json: @team_goal.as_json}
      f.js
    end
  end

  # POST /team_goals
  def create
    @team_goal = TeamGoal.new(team_goal_params)
    respond_to do |f|
      if @team_goal.save
        @team_goal.create_individual_goals
        f.html { redirect_to @team_goal.redirect_url || redirect_url || team_goal_url(@team_goal), notice: controller_t('.saved') }
        f.json { render json: @team_goal.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @team_goal.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /team_goals/1
  def update
    respond_to do |f|
      if @team_goal.update(team_goal_params)
        f.html { redirect_to @team_goal.redirect_url || redirect_url || team_goal_url(@team_goal), notice: controller_t('.updated') }
        f.json { render json: @team_goal.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @team_goal.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /team_goals/1
  def destroy
    @team_goal.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || team_goals_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_goal
      @team_goal = TeamGoal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def team_goal_params
      params.require(:team_goal).permit(:general_goal_id, :who_belongs, {employee_ids:[], function_ids:[], position_ids:[]}, :assessment_id, :period, :objectives, :target, :mode, :cancel_url, :redirect_url)
    end
end
