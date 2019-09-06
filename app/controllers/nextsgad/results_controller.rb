  class Nextsgad::ResultsController < NextSgad::ResultsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Result

    before_action :set_result, only: [:show, :edit, :update, :destroy]

    # GET /results
    def index
      respond_to do |format|
        format.html { @results = Result.all }
        format.json {render json: @results}
      end
    end

    def change_status
      @result = Result.find(params[:result_id])

      @result.change_status
      if @result.result_invalid?
        # Activity.notification_result_invalidate(current.user, @result)
      else
        # Activity.notification_result_validate(current.user, @result)
      end
      @result.employee_goal.update_amount if @result.numeric?

      respond_to do |format|
        format.html { head :no_content }
        format.js
      end
    end

    # GET /results/1
    def show
    end

    # GET /results/new
    def new
      @result = Result.new
      @result.employee_goal_id = params[:employee_goal_id].to_i
      @employee_goal = EmployeeGoal.find(@result.employee_goal_id)
    end

    # GET /results/1/edit
    def edit
    end

    # POST /results
    def create
      @result = Result.new(result_params)
      respond_to do |format|
        if @result.save
          EmployeeGoalActivity.create(employee_goal_id: @result.employee_goal_id, description: t(:added_x_results, count: @result.result_value.trim_decimal)) do |activity|
            activity.creator = current_account
          end
          format.html { redirect_to results_url, notice: 'register_was_successfully_created'.ts }
          format.js

        else
          format.html { render :new }
          format.js
        end
      end
    end

    # PATCH/PUT /results/1
    def update
      if @result.update(result_params)
        redirect_to @result, notice: 'register_was_successfully_updated'.ts
      else
        render :edit
      end
    end

    # DELETE /results/1
    def destroy
      result = @result
      @result.destroy

      respond_to do |format|
        format.html { redirect_to results_url, notice: 'register_was_successfully_destroyed'.ts }
        format.js { head :no_content }

        # Activity.notification_destroy_result(current.user, result)
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_result
        @result = Result.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def result_params
        params.require(:result).permit(:note, :status, :attachment, :employee_goal_id, :result_value)
      end
  end
