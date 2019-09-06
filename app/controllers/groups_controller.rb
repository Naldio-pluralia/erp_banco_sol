class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /groups
  def index
    @groups = Group.all
    @group = Group.new
    @group.cancel_and_redirect_url_to(groups_url)
    respond_to do |f|
      f.html
      f.json { render json: @groups.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /groups/1
  def show
    @group.cancel_and_redirect_url_to(group_url(@group))

    @employees = @group.employees
    @positions = @group.positions
    @functions = @group.functions

    respond_to do |f|
      f.html
      f.json { render json: @group.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    @group.cancel_url = groups_url
    respond_to do |f|
      f.html
      f.json { render json: @group.as_json}
      f.js
    end
  end

  # GET /groups/1/edit
  def edit
    @group.cancel_and_redirect_url_to(group_url(@group))
    respond_to do |f|
      f.html
      f.json { render json: @group.as_json}
      f.js
    end
  end

  # POST /groups
  def create
    @group = Group.new(group_params)
    respond_to do |f|
      if @group.save
        f.html { redirect_to @group.redirect_url || redirect_url || group_url(@group), notice: controller_t('.saved') }
        f.json { render json: @group.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @group.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /groups/1
  def update
    respond_to do |f|
      if @group.update(group_params)
        f.html { redirect_to @group.redirect_url || redirect_url || group_url(@group), notice: controller_t('.updated') }
        f.json { render json: @group.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @group.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy

    respond_to do |f|
      f.html { redirect_to redirect_url || groups_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:status, :cancel_url, :redirect_url, :group_type, {employee_ids:[], function_ids:[], position_ids:[]})
    end
end
