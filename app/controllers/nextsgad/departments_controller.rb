module Nextsgad
  class DepartmentsController < NextSgad::DepartmentsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Department

    before_action :set_department, only: [:show, :edit, :update, :destroy]

    # GET /departments
    def index
      @department = Department.new
      @upload = Upload.new(type: 'departments')

      @o = Department.all.group_by {|d| [d.class.name, d.id]}
      @o.merge Position.all.group_by {|d| [d.class.name, d.id]}
      @o.merge Employee.all.group_by {|d| [d.class.name, d.id]}
      @departments = Department.all
                         .department_id(params[:department_id])

      @name_departaments = Department.all.map {|m| [m.name, m.name] if m.name.present?}

      # unless params[:name].blank?
      #   @departments = @departments.name(params[:name])
      # end

      respond_to do |format|
        format.html
        format.xls
        format.pdf do
          send_data Departments.new(@departments, params, current, view_context).render, filename: "#{t :departments}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end

    end

    # GET /departments/1
    def show
    end

    # GET /departments/new
    def new
      @department = Department.new
    end

    # GET /departments/1/edit
    def edit
    end

    # POST /departments
    def create
      @department = Department.new(department_params)

      if @department.save
        redirect_to departments_url, notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /departments/1
    def update
      if @department.update(department_params)
        redirect_to @department, notice: 'register_was_successfully_updated'.ts
      else
        render :edit
      end
    end

    # DELETE /departments/1
    def destroy
      @department.destroy
      redirect_to departments_url, notice: 'register_was_successfully_destroyed'.ts
    end

    def organigram
      @department = Department.new
      @departments = Department.all
      @root = Department.find_by(id: params[:root_id]) || Department.where(department_id: nil).first
      if @root.present?
        @return = org_data(@root, @departments)
      else
        @return = {}
      end

      respond_to do |format|
        format.html
        format.json {render json: @return}
      end
    end

    # Creates the org chart data
    def org_data(root, departments)
      data = {}
      children = departments.group_by {|p| p.department_id}[root.id] || []
      sibling_num = (departments.group_by {|p| p.department_id}[root.department_id] || []).size - 1
      sibling_num = 0 if sibling_num < 0
      parent_num = root.department_id.present? ? 1 : 0
      data[:id] = root.id
      data[:name] = root.name
      data[:number] = root.number

      data[:children] = [] if children.size > 0
      children.each do |child|
        data[:children] << org_data(child, departments)
      end
      data[:relationship] = {children_num: children.size, sibling_num: sibling_num, parent_num: parent_num}
      data
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params.require(:department).permit(:name, :description, :number, :department_id, :employee_id)
    end
  end
end
