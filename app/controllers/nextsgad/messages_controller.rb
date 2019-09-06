module Nextsgad
  class MessagesController < NextSgad::MessagesController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Message

    # GET /messages
    def index
      @messages = Message.all.order(updated_at: :desc)
      @message = Message.new
    end

    # GET /messages/1
    def show
    end

    # GET /messages/new
    def new
      @message = Message.new
    end

    # GET /messages/1/edit
    def edit
    end

    # POST /messages
    def create
      @message = Message.new(message_params)
      @message.status = 1 if params[:commit] == t(:save_and_send)

      if @message.save
        redirect_to @message, notice: t(".#{@message.status}.success")
      else
        render :new
      end
    end

    # PATCH/PUT /messages/1
    def update
      @message.status = 1 if params[:commit] == t(:save_and_send)
      if @message.update(message_params)
        redirect_to @message, notice: t(".#{@message.status}.success")
      else
        render :edit
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
      redirect_to messages_url, notice: t('.destroyed')
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:title, :body, :signature, :send_to_all, :status, {function_ids: [], position_ids: [], employee_ids: [], organic_unit_ids:[]})
      end
  end
end
