class ObjectActivitiesController < ApplicationController
  before_action :set_object_activity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  layout :resolve_layout

  # GET /object_activities
  def index
    @object_activities = ObjectActivity.all
    @object_activity = ObjectActivity.new
    @object_activity.cancel_and_redirect_url_to(object_activities_url)
    respond_to do |f|
      f.html
      f.json { render json: @object_activities.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_activities/1
  def show
    @object_activity.cancel_and_redirect_url_to(object_activity_url(@object_activity))
    respond_to do |f|
      f.html
      f.json { render json: @object_activity.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /object_activities/new
  def new
    @object_activity = ObjectActivity.new
    @object_activity.cancel_url = object_activities_url
    respond_to do |f|
      f.html
      f.json { render json: @object_activity.as_json}
      f.js
    end
  end

  # GET /object_activities/1/edit
  def edit
    @object_activity.cancel_and_redirect_url_to(object_activity_url(@object_activity))
    respond_to do |f|
      f.html
      f.json { render json: @object_activity.as_json}
      f.js
    end
  end

  # POST /object_activities
  def create
    @object_activity = ObjectActivity.new(object_activity_params)
    @object_activity.creator = current.user
    respond_to do |f|
      if @object_activity.save
        f.html { redirect_to @object_activity.redirect_url || object_activity_url(@object_activity), notice: controller_t('.saved') }
        f.json { render json: @object_activity.as_json}
        f.js { render :activities }
      else
        f.html { render :new }
        f.json { render json: @object_activity.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /object_activities/1
  def update
    respond_to do |f|
      if @object_activity.update(object_activity_params)
        f.html { redirect_to @object_activity.redirect_url || object_activity_url(@object_activity), notice: controller_t('.updated') }
        f.json { render json: @object_activity.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @object_activity.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /object_activities/1
  def destroy
    @object_activity.destroy
    
    respond_to do |f|
      f.html { redirect_to object_activities_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_activity
      @object_activity = ObjectActivity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def object_activity_params
      params.require(:object_activity).permit(:description, :object_id, :object_type, :creator_id, :creator_type, :cancel_url, :redirect_url)
    end
end
