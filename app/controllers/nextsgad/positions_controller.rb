class Nextsgad::PositionsController < NextSgad::PositionsController
  # initial action and setup
  before_action :authenticate_account!
  load_and_authorize_resource class: Position
  before_action :set_position, only: [:show, :edit, :update, :destroy]
  before_action :get_efectives_employees, only: [:index, :show, :edit]

  # GET /positions
  def index
    @position = Position.new
    @upload = Upload.new(type: 'positions')
    @positions = Position.includes([:organic_unit, :establishment, {efective: :latest_paygrade}, :function, :position])
                    .organic_unit_id(params[:organic_unit_id])
                    .establishment_id(params[:establishment_id])
                    .efective_id(params[:efective_id])
                    .position_id(params[:position_id])
    respond_to do |format|
      format.html
      format.xls
      format.json{render json: @positions}
      format.pdf do
        send_data Positions.new(@positions, params, current, view_context).render, filename: "#{t(:positions)}.pdf", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  # GET /positions/1
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /positions
  def create
    @position = Position.new(position_params)
    if @position.save
      redirect_to positions_url, notice: 'register_was_successfully_created'.ts
    else
      render :new
    end
  end

  # PATCH/PUT /positions/1
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html {redirect_to @position, notice: 'register_was_successfully_updated'.ts}
        format.js
      else
        format.html {render :edit}
        format.js
      end
    end
  end

  # DELETE /positions/1
  def destroy
    @position.destroy
    redirect_to positions_url, notice: 'register_was_successfully_destroyed'.ts
  end

  def get_efectives_employees
    if current.is?(:hr)
      @efectives = Employee.all.map {|v| [v.first_and_last_name, v.id]}
    elsif current.is?(:manager)
      @efectives = Employee.where.not(id: Position.where.not(id: @position&.id).map(&:efective_id)).map {|v| [v.first_and_last_name, v.id]}
    elsif current.is?(:admin)
      @efectives = Employee.all.map {|v| [v.first_and_last_name, v.id]}
    end
  end

  def organigram
    @position = Position.new
    @o = (Department.all + Position.all + Employee.all).group_by {|x| [x.class.name, x.id]}
    @positions = Position.all
    @root = Position.find_by(id: params[:root_id]) || Position.where(position_id: nil).first
    if @root.present?
      @return = org_data(@root, @positions)
    else
      @return = {}
    end

    respond_to do |format|
      format.html
      format.xls
      format.json {render json: @return}
    end
  end


  # user's team (my team) orgchart
  def my_team_orgchart
    @positions = Position.where(position_id: current.position.id)
    @root = Position.find_by(id: current.position.id)

    if @root.present?
      @return = org_data(@root, @positions)
    else
      @return = {}
    end

    respond_to do |format|
      format.html
      format.xls
      format.json {render json: @return}
    end
  end

  # user(employee) orgchart
  def my_orgchart
    # geral = Position.find_by(id: current.position.id)
    # my_supervisor = Position.find_by(id: current.position.id).position
    # @positions = Position.all#.where(position_id: my_supervisor.id)
    # @root = Position.find_by(id: current.position.id).position.present? ? Position.find_by(id: current.position.id).position : Position.find_by(id: current.position.id) #my_supervisor.blank? ? geral : my_supervisor

    @positions = Position.all
    @root = Position.find_by(id: params[:root_id]) || Position.where(position_id: nil).first

    if @root.present?
      @return = org_data(@root, @positions)
    else
      @return = {}
    end

    respond_to do |format|
      format.html
      format.json {render json: @return}
    end
  end

  def create_position
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        format.html {redirect_to organigram_url, notice: 'register_was_successfully_created'.ts}
        format.js
      else
        format.html {render :organigram}
        format.js
      end
    end
  end

  def org_data(root, positions)
    data = {}

    # groups position by supervisor
    children = positions.group_by {|p| p.position_id}[root.id] || []

    # groups position by root supervisor
    sibling_num = (positions.group_by {|p| p.position_id}[root.position_id] || []).size - 1
    sibling_num = 0 if sibling_num < 0
    parent_num = root.position_id.present? ? 1 : 0
    data[:id] = root.id

    data[:my_position] = current.is?(:admin) ? "" : (root.efective_id == current.user.employee_id && !(action_name == "organigram")) ? "my-position-orgchart" : "another-position"
    data[:positin_title] = current.is?(:admin) ? "" : (root.efective_id == current.user.employee_id && !(action_name == "organigram")) ? "my-position-tile" : "another-position-tile"

    if (action_name == "my_orgchart") && !current.admin?
      geral = Position.find_by(id: current.position.id)
      my_supervisor = Position.find_by(id: current.position.id).position
      my_supervisor = my_supervisor.blank? ? geral : my_supervisor
      data[:my_supervisor_color] = (root.id == my_supervisor.id) ? "supervisor_color" : ""
    end

    data[:modal_url] = ""
    data[:function] = root.function&.name || 'N/D'
    data[:name] = root.efective.blank? ? 'N/D' : "#{root.efective&.first_name} #{root.efective&.last_name}"
    data[:avatar] = root.efective&.avatar_url

    data[:ocupation] = root.name
    data[:department] = root.department&.name || 'N/D'
    data[:level] = root.efective&.level || 'N/D'
    data[:paygrade] = root.efective&.paygrade || 'N/D'
    data[:department_id] = root.department&.id
    data[:employee_id] = root.efective&.id || 'N/D'
    data[:employee_number] = root.efective&.number || 'N/D'
    data[:children] = [] if children.size > 0

    children.each do |child|
      data[:children] << org_data(child, positions)
    end

    data[:relationship] = {children_num: children.size, sibling_num: sibling_num, parent_num: parent_num}
    data
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_position
    @position = Position.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def position_params
    params.require(:position).permit(:name, :description, :position_id, :department_id, :efective_id, {employee_ids: [], establishment_ids: []}, :function_id, :organic_unit_id, :establishment_id )
  end
end
