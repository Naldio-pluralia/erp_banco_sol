class CorporateGoalsController < ApplicationController
  before_action :set_corporate_goal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /corporate_goals
  def index
    @corporate_goals = CorporateGoal.all
    @corporate_goal = CorporateGoal.new
    @corporate_goal.cancel_and_redirect_url_to(corporate_goals_url)
    respond_to do |f|
      f.html
      f.json { render json: @corporate_goals.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /corporate_goals/1
  def show
    @corporate_goal.cancel_and_redirect_url_to(corporate_goal_url(@corporate_goal))
    respond_to do |f|
      f.html
      f.json { render json: @corporate_goal.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /corporate_goals/new
  def new
    @corporate_goal = CorporateGoal.new
    @corporate_goal.cancel_url = corporate_goals_url
    respond_to do |f|
      f.html
      f.json { render json: @corporate_goal.as_json}
      f.js
    end
  end

  # GET /corporate_goals/1/edit
  def edit
    @corporate_goal.cancel_and_redirect_url_to(corporate_goal_url(@corporate_goal))
    respond_to do |f|
      f.html
      f.json { render json: @corporate_goal.as_json}
      f.js
    end
  end

  # POST /corporate_goals
  def create
    @corporate_goal = CorporateGoal.new(corporate_goal_params)
    respond_to do |f|
      if @corporate_goal.save
        @corporate_goal.create_individual_goals
        f.html { redirect_to @corporate_goal.redirect_url || redirect_url || corporate_goal_url(@corporate_goal), notice: controller_t('.saved') }
        f.json { render json: @corporate_goal.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @corporate_goal.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /corporate_goals/1
  def update
    respond_to do |f|
      if @corporate_goal.update(corporate_goal_params)
        f.html { redirect_to @corporate_goal.redirect_url || redirect_url || corporate_goal_url(@corporate_goal), notice: controller_t('.updated') }
        f.json { render json: @corporate_goal.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @corporate_goal.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /corporate_goals/1
  def destroy
    @corporate_goal.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || corporate_goals_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporate_goal
      @corporate_goal = CorporateGoal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def corporate_goal_params
      params.require(:corporate_goal).permit(:general_goal_id, :who_belongs, {employee_ids:[], function_ids:[], position_ids:[]}, :assessment_id, :period, :objectives, :target, :mode, :cancel_url, :redirect_url)
    end
end
