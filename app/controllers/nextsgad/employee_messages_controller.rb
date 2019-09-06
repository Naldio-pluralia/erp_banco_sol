module Nextsgad
  class EmployeeMessagesController < NextSgad::EmployeeMessagesController
    before_action :set_employee
    before_action :set_employee_message, only: [:show, :edit, :update, :destroy]
    load_resource :employee, class: Employee
    load_and_authorize_resource :employee_message, through: :employee, class: EmployeeMessage

    # GET /employee_messages
    def index
      @employee_messages = EmployeeMessage.where(employee_id: @employee.id, status: [0,1]).order(created_at: :desc)
    end

    # GET /employee_messages/1
    def show
      @employee_message.mark_as_read(current.employee)
    end

    # # GET /employee_messages/new
    # def new
    #   @employee_message = EmployeeMessage.new
    # end

    # # GET /employee_messages/1/edit
    # def edit
    # end

    # # POST /employee_messages
    # def create
    #   @employee_message = EmployeeMessage.new(employee_message_params)
    #
    #   if @employee_message.save
    #     redirect_to @employee_message, notice: 'Employee message was successfully created.'
    #   else
    #     render :new
    #   end
    # end

    # # PATCH/PUT /employee_messages/1
    # def update
    #   if @employee_message.update(employee_message_params)
    #     redirect_to @employee_message, notice: 'Employee message was successfully updated.'
    #   else
    #     render :edit
    #   end
    # end

    # DELETE /employee_messages/1
    def destroy
      @employee_message.destroy
      redirect_to employee_employee_messages_url(@employee), notice: 'Employee message was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_employee_message
        @employee_message = EmployeeMessage.find(params[:id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_employee
        @employee = Employee.find(params[:employee_id])
      end

      # Only allow a trusted parameter "white list" through.
      def employee_message_params
        params.require(:employee_message).permit(:message, :employee, :status, :title, :body, :signature)
      end
  end
end
