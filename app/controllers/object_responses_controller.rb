class ObjectResponsesController < ApplicationController
  before_action :set_object_response, only: [:approve, :disaprove, :remove]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # # GET /object_responses
  # def index
  #   @object_responses = ObjectResponse.all
  #   @object_response = ObjectResponse.new
  #   @object_response.cancel_and_redirect_url_to(object_responses_url)
  #   respond_to do |f|
  #     f.html
  #     f.json { render json: @object_responses.as_json}
  #     f.js
  #     f.xls
  #     f.pdf
  #   end
  # end

  # # GET /object_responses/1
  # def show
  #   @object_response.cancel_and_redirect_url_to(object_response_url(@object_response))
  #   respond_to do |f|
  #     f.html
  #     f.json { render json: @object_response.as_json}
  #     f.js
  #     f.xls
  #     f.pdf
  #   end
  # end

  # # GET /object_responses/new
  # def new
  #   @object_response = ObjectResponse.new
  #   @object_response.cancel_url = object_responses_url
  #   respond_to do |f|
  #     f.html
  #     f.json { render json: @object_response.as_json}
  #     f.js
  #   end
  # end

  # # GET /object_responses/1/edit
  # def edit
  #   @object_response.cancel_and_redirect_url_to(object_response_url(@object_response))
  #   respond_to do |f|
  #     f.html
  #     f.json { render json: @object_response.as_json}
  #     f.js
  #   end
  # end

  # # POST /object_responses
  # def create
  #   @object_response = ObjectResponse.new(object_response_params)
  #   respond_to do |f|
  #     if @object_response.save
  #       f.html { redirect_to @object_response.redirect_url || redirect_url || object_response_url(@object_response), notice: controller_t('.saved') }
  #       f.json { render json: @object_response.as_json}
  #       f.js { render :show }
  #     else
  #       f.html { render :new }
  #       f.json { render json: @object_response.errors, status: :unprocessable_entity }
  #       f.js { render :new }
  #     end
  #   end
  # end

  # # PATCH/PUT /object_responses/1
  # def update
  #   respond_to do |f|
  #     if @object_response.update(object_response_params)
  #       f.html { redirect_to @object_response.redirect_url || redirect_url || object_response_url(@object_response), notice: controller_t('.updated') }
  #       f.json { render json: @object_response.as_json}
  #       f.js { render :show }
  #     else
  #       f.html { render :edit }
  #       f.json { render json: @object_response.errors, status: :unprocessable_entity }
  #       f.js { render :edit }
  #     end
  #   end
  # end

  # # DELETE /object_responses/1
  # def destroy
  #   @object_response.destroy

  #   respond_to do |f|
  #     f.html { redirect_to redirect_url || object_responses_url, notice: controller_t('.destroyed') }
  #     f.json { head :no_content }
  #     f.js { render :index }
  #   end
  # end

  def approve
    @object_response.update(employee_id: current.employee&.id, status: :approved)
    @object_response.send_notification_approve
    respond_to do |f|
      f.html { redirect_to redirect_url, notice: controller_t('.updated') }
      f.json { render json: @object_response.as_json}
      f.js { render :status }
    end
  end

  def disaprove
    @object_response.update(employee_id: current.employee&.id, status: :not_approved)
    @object_response.send_notification_disaprove
    respond_to do |f|
      f.html { redirect_to redirect_url, notice: controller_t('.updated') }
      f.json { render json: @object_response.as_json}
      f.js { render :status }
    end
  end

  def remove
    @object_response.update(employee_id: nil, status: :pending)
    respond_to do |f|
      f.html { redirect_to redirect_url, notice: controller_t('.updated') }
      f.json { render json: @object_response.as_json}
      f.js { render :status }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_response
      @object_response = ObjectResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def object_response_params
      params.require(:object_response).permit(:employee_id, :object_id, :object_type, :status, :kind, :cancel_url, :redirect_url)
    end
end
