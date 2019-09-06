class Nextsgad::ActivitiesController < NextSgad::ActivitiesController
  before_action :authenticate_account!
  load_and_authorize_resource class: Activity

  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  def index
    respond_to do |format|
      format.html { @activities = Activity.all }
      format.json {render json: @activities}
    end
  end

  # GET /activities/1
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to @activity, notice: 'register_was_successfully_created'.ts
    else
      render :new
    end
  end

  # PATCH/PUT /activities/1
  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: 'register_was_successfully_updated'.ts
    else
      render :edit
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
    redirect_to activities_url, notice: 'register_was_successfully_destroyed'.ts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def activity_params
      params.require(:activity).permit(:created_by, :description)
    end
end
