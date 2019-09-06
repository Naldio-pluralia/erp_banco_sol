class SalaryBoardsController < ApplicationController
  before_action :set_salary_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # # GET /salary_boards
  # def index
  #   @salary_boards = SalaryBoard.all
  #   # @salary_board = SalaryBoard.new
  # end

  # # GET /salary_boards/1
  # def show
  # end

  # GET /salary_boards/new
  def new
    @salary_board = SalaryBoard.new
    @salary_board.salary_board_items.build([{base_value: RemunerationSetting.last&.base_salary || 0, paygrade: 1}, {paygrade: 2}, {paygrade: 3}, {paygrade: 4}, {paygrade: 5}, {paygrade: 6}, {paygrade: 7}, {paygrade: 8}, {paygrade: 9}, {paygrade: 10}])
  end

  # GET /salary_boards/1/edit
  def edit
  end

  # POST /salary_boards
  def create
    @salary_board = SalaryBoard.new(salary_board_params)

    if @salary_board.save
      redirect_to latest_salary_board_url, notice: t('.success')
    else
      render :new
    end
  end

  # # PATCH/PUT /salary_boards/1
  # def update
  #   if @salary_board.update(salary_board_params)
  #     redirect_to @salary_board, notice: t('.success')
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /salary_boards/1
  # def destroy
  #   @salary_board.destroy
  #   redirect_to salary_boards_url, notice: t('.success')
  # end
  
  def latest
    @salary_board = SalaryBoard.latest || SalaryBoard.new
    if @salary_board.new_record? || @salary_board.salary_board_items.empty?
      @salary_board.salary_board_items.build([{base_value: (RemunerationSetting.last&.base_salary || 0), paygrade: 1}, {paygrade: 2}, {paygrade: 3}, {paygrade: 4}, {paygrade: 5}, {paygrade: 6}, {paygrade: 7}, {paygrade: 8}, {paygrade: 9}, {paygrade: 10}])
    else

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_board
      @salary_board = SalaryBoard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_board_params
      params.require(:salary_board).permit(:status, :cancel_url, :redirect_url, salary_board_items_attributes: [:increment_value])
    end
end
# 19500 dados
