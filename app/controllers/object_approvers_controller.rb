class ObjectApproversController < ApplicationController
  before_action :set_object_approver, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /object_approvers
  def index
    @object_approvers = ObjectApprover.all
    @object_approver = ObjectApprover.new
    @object_approver.cancel_and_redirect_url_to(object_approvers_url)
    respond_to do |f|
      f.html
      f.json { render json: @object_approvers.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_approvers/1
  def show
    @object_approver.cancel_and_redirect_url_to(object_approver_url(@object_approver))
    respond_to do |f|
      f.html
      f.json { render json: @object_approver.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_approvers/new
  def new
    @object_approver = ObjectApprover.new
    @object_approver.cancel_url = object_approvers_url
    respond_to do |f|
      f.html
      f.json { render json: @object_approver.as_json}
      f.js
    end
  end

  # GET /object_approvers/1/edit
  def edit
    @object_approver.cancel_and_redirect_url_to(object_approver_url(@object_approver))
    respond_to do |f|
      f.html
      f.json { render json: @object_approver.as_json}
      f.js
    end
  end

  # POST /object_approvers
  def create
    @object_approver = ObjectApprover.new(object_approver_params)
    respond_to do |f|
      if @object_approver.save
        f.html { redirect_to @object_approver.redirect_url || redirect_url || object_approver_url(@object_approver), notice: controller_t('.saved') }
        f.json { render json: @object_approver.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @object_approver.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /object_approvers/1
  def update
    respond_to do |f|
      if @object_approver.update(object_approver_params)
        f.html { redirect_to @object_approver.redirect_url || redirect_url || object_approver_url(@object_approver), notice: controller_t('.updated') }
        f.json { render json: @object_approver.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @object_approver.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /object_approvers/1
  def destroy
    @object_approver.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || object_approvers_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_approver
      @object_approver = ObjectApprover.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def object_approver_params
      params.require(:object_approver).permit(:employee_id, :kind, :object_id, :object_type, :cancel_url, :redirect_url)
    end
end
