class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /skills
  def index
    @skills = Skill.all
    @skill = Skill.new
    @skill.cancel_and_redirect_url_to(skills_url)
    respond_to do |f|
      f.html
      f.json { render json: @skills.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /skills/1
  def show
    @skill.cancel_and_redirect_url_to(skill_url(@skill))
    respond_to do |f|
      f.html
      f.json { render json: @skill.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  def skills_map
    @employees = Employee
                     .none_if_blank(params, :organic_unit_id, :function_id, :position_id, :paygrade, :level, :employee_id)
                     .organic_unit_id(params[:organic_unit_id])
                     .function_id(params[:function_id])
                     .position_id(params[:position_id])
                     .employee_id(params[:employee_id])
                     .paygrade(params[:paygrade])
                     .level(params[:level])

    # total das avaliacoes
    # @total_assessed_self      = Skill.total_assessed_self
    # @assessed_self            = Skill.percentage(Skill.assessed_self, @total_assessed_self)
    # @not_assessed_self        = Skill.percentage(Skill.not_assessed_self, @total_assessed_self)
    #
    # @total_assessed_supervisor  = Skill.total_assessed_supervisor
    # @assessed_supervisor        = Skill.percentage(Skill.assessed_supervisor, @total_assessed_supervisor)
    # @not_assessed_supervisor    = Skill.percentage(Skill.not_assessed_supervisor, @total_assessed_supervisor)
    #
    # @total_assessed_final     = Skill.total_assessed_final
    # @assessed_final           = Skill.percentage(Skill.assessed_final, @total_assessed_final)
    # @not_assessed_final       = Skill.percentage(Skill.not_assessed_final, @total_assessed_final)

    @employee_skills          = Skill.employees_assessments(@employees.ids)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        send_data SkillsMap.new(@employee_skills, view_context).render, filename: "colaboradores.pdf", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  # GET /skills/new
  def new
    @skill = Skill.new
    @skill.cancel_url = skills_url
    respond_to do |f|
      f.html
      f.json { render json: @skill.as_json}
      f.js
    end
  end

  # GET /skills/1/edit
  def edit
    @skill.cancel_and_redirect_url_to(skill_url(@skill))
    respond_to do |f|
      f.html
      f.json { render json: @skill.as_json}
      f.js
    end
  end

  # POST /skills
  def create
    @skill = Skill.new(skill_params)
    respond_to do |f|
      if @skill.save
        f.html { redirect_to @skill.redirect_url || redirect_url || skill_url(@skill), notice: controller_t('.saved') }
        f.json { render json: @skill.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @skill.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /skills/1
  def update
    respond_to do |f|
      if @skill.update(skill_params)
        f.html { redirect_to @skill.redirect_url || redirect_url || skill_url(@skill), notice: controller_t('.updated') }
        f.json { render json: @skill.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @skill.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || skills_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:name, :cancel_url, :redirect_url)
    end
end
