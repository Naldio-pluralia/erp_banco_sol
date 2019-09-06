class GeneralGoalsController < ApplicationController
  before_action :set_general_goal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /general_goals
  def index
    @general_goals = GeneralGoal.all
    @general_goal = GeneralGoal.new
    @general_goal.cancel_and_redirect_url_to(general_goals_url)
    respond_to do |f|
      f.html
      f.json { render json: @general_goals.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /general_goals/1
  def show
    @general_goal.cancel_and_redirect_url_to(general_goal_url(@general_goal))
    respond_to do |f|
      f.html
      f.json { render json: @general_goal.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /general_goals/new
  def new
    @general_goal = GeneralGoal.new
    @general_goal.cancel_url = general_goals_url
    respond_to do |f|
      f.html
      f.json { render json: @general_goal.as_json}
      f.js
    end
  end

  # GET /general_goals/1/edit
  def edit
    @general_goal.cancel_and_redirect_url_to(general_goal_url(@general_goal))
    respond_to do |f|
      f.html
      f.json { render json: @general_goal.as_json}
      f.js
    end
  end

  # POST /general_goals
  def create
    @general_goal = GeneralGoal.new(general_goal_params)
    respond_to do |f|
      if @general_goal.save
        @general_goal.create_individual_goals
        f.html { redirect_to @general_goal.redirect_url || redirect_url || general_goal_url(@general_goal), notice: controller_t('.saved') }
        f.json { render json: @general_goal.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @general_goal.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /general_goals/1
  def update
    respond_to do |f|
      if @general_goal.update(general_goal_params)
        f.html { redirect_to @general_goal.redirect_url || redirect_url || general_goal_url(@general_goal), notice: controller_t('.updated') }
        f.json { render json: @general_goal.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @general_goal.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /general_goals/1
  def destroy
    @general_goal.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || general_goals_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_general_goal
      @general_goal = GeneralGoal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def general_goal_params
      params.require(:general_goal).permit(:assessment_id, :period, :objectives, :target, :mode, {employee_ids:[], function_ids:[], position_ids:[]}, :cancel_url, :redirect_url)
    end
end
