class FunctionSkillsController < ApplicationController
  before_action :set_function_skill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /function_skills
  def index
    @function_skills = FunctionSkill.all
    @function_skill = FunctionSkill.new
    @function_skill.cancel_and_redirect_url_to(function_skills_url)
    respond_to do |f|
      f.html
      f.json { render json: @function_skills.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_skills/1
  def show
    @function_skill.cancel_and_redirect_url_to(function_skill_url(@function_skill))
    respond_to do |f|
      f.html
      f.json { render json: @function_skill.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /function_skills/new
  def new
    @function_skill = FunctionSkill.new
    @function_skill.cancel_url = function_skills_url
    respond_to do |f|
      f.html
      f.json { render json: @function_skill.as_json}
      f.js
    end
  end

  # GET /function_skills/1/edit
  def edit
    @function_skill.cancel_and_redirect_url_to(function_skill_url(@function_skill))
    respond_to do |f|
      f.html
      f.json { render json: @function_skill.as_json}
      f.js
    end
  end

  # POST /function_skills
  def create
    @function_skill = FunctionSkill.new(function_skill_params)
    respond_to do |f|
      if @function_skill.save
        f.html { redirect_to @function_skill.redirect_url || redirect_url || function_skill_url(@function_skill), notice: controller_t('.saved') }
        f.json { render json: @function_skill.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @function_skill.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /function_skills/1
  def update
    respond_to do |f|
      if @function_skill.update(function_skill_params)
        f.html { redirect_to @function_skill.redirect_url || redirect_url || function_skill_url(@function_skill), notice: controller_t('.updated') }
        f.json { render json: @function_skill.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @function_skill.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /function_skills/1
  def destroy
    @function_skill.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || function_skills_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function_skill
      @function_skill = FunctionSkill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_skill_params
      params.require(:function_skill).permit(:min, :recomended, :skill_id, :function_id, :cancel_url, :redirect_url)
    end
end
