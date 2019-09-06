class EmployeeSkillsController < ApplicationController
  before_action :set_employee_skill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /employee_skills
  def index
    @employee_skills = EmployeeSkill.all
    @employee_skill = EmployeeSkill.new
    @employee_skill.cancel_and_redirect_url_to(employee_skills_url)
    respond_to do |f|
      f.html
      f.json { render json: @employee_skills.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_skills/1
  def show
    @employee_skill.cancel_and_redirect_url_to(employee_skill_url(@employee_skill))
    respond_to do |f|
      f.html
      f.json { render json: @employee_skill.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /employee_skills/new
  def new
    @employee_skill = EmployeeSkill.new
    @employee_skill.cancel_url = employee_skills_url
    respond_to do |f|
      f.html
      f.json { render json: @employee_skill.as_json}
      f.js
    end
  end

  # GET /employee_skills/1/edit
  def edit
    @employee_skill.cancel_and_redirect_url_to(employee_skill_url(@employee_skill))
    respond_to do |f|
      f.html
      f.json { render json: @employee_skill.as_json}
      f.js
    end
  end

  # POST /employee_skills
  def create
    @employee_skill = EmployeeSkill.new(employee_skill_params)
    respond_to do |f|
      if @employee_skill.save
        f.html { redirect_to @employee_skill.redirect_url || redirect_url || employee_skill_url(@employee_skill), notice: controller_t('.saved') }
        f.json { render json: @employee_skill.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @employee_skill.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /employee_skills/1
  def update
    respond_to do |f|
      if @employee_skill.update(employee_skill_params)
        f.html { redirect_to @employee_skill.redirect_url || redirect_url  || employee_url(@employee_skill.employee), notice: controller_t('.updated') }
        f.json { render json: @employee_skill.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @employee_skill.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /employee_skills/1
  def destroy
    @employee_skill.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || employee_skills_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_skill
      @employee_skill = EmployeeSkill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_skill_params
      params.require(:employee_skill).permit(:skill_id, :employee_id, :self_assessment, :supervisor_assessment, :value, :cancel_url, :redirect_url)
    end
end
