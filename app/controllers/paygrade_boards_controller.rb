class PaygradeBoardsController < ApplicationController
  before_action :set_paygrade_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /paygrade_boards
  # GET /paygrade_boards.json
  def index
    @paygrade_boards = PaygradeBoard.all
    @paygrade_board = PaygradeBoard.new
  end

  # GET /paygrade_boards/1
  # GET /paygrade_boards/1.json
  def show
  end

  # GET /paygrade_boards/new
  def new
    @paygrade_board = PaygradeBoard.new
  end

  # GET /paygrade_boards/1/edit
  def edit
  end

  # POST /paygrade_boards
  # POST /paygrade_boards.json
  def create
    @paygrade_board = PaygradeBoard.new(paygrade_board_params)

    respond_to do |format|
      if @paygrade_board.save
        format.html { redirect_to latest_paygrade_board_url, notice: 'Paygrade board was successfully created.' }
        format.json { render :show, status: :created, location: @paygrade_board }
      else
        format.html { render :new }
        format.json { render json: @paygrade_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paygrade_boards/1
  # PATCH/PUT /paygrade_boards/1.json
  def update
    respond_to do |format|
      @paygrade_board.assign_attributes(paygrade_board_params)
      if @paygrade_board.valid?
        @new_paygrade_board = @paygrade_board.dup
        @new_paygrade_board.save
        format.html { redirect_to latest_paygrade_board_url, notice: t('.success') }
        format.json { render :show, status: :ok, location: @paygrade_board }
      else
        format.html { render :edit }
        format.json { render json: @paygrade_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paygrade_boards/1
  # DELETE /paygrade_boards/1.json
  def destroy
    @paygrade_board.destroy
    respond_to do |format|
      format.html { redirect_to latest_paygrade_board_url, notice: 'Paygrade board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def latest
    @paygrade_board = PaygradeBoard.all.order(id: :asc).last
    return if @paygrade_board.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paygrade_board
      @paygrade_board = PaygradeBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paygrade_board_params
      params.require(:paygrade_board).permit(:status, :level_1_value, :level_1_increment, :level_1_a_value, :level_1_b_value, :level_1_c_value, :level_1_d_value, :level_2_value, :level_2_increment, :level_2_a_value, :level_2_b_value, :level_2_c_value, :level_2_d_value, :level_3_value, :level_3_increment, :level_3_a_value, :level_3_b_value, :level_3_c_value, :level_3_d_value, :level_4_value, :level_4_increment, :level_4_a_value, :level_4_b_value, :level_4_c_value, :level_4_d_value, :level_5_value, :level_5_increment, :level_5_a_value, :level_5_b_value, :level_5_c_value, :level_5_d_value, :level_6_value, :level_6_increment, :level_6_a_value, :level_6_b_value, :level_6_c_value, :level_6_d_value, :level_7_value, :level_7_increment, :level_7_a_value, :level_7_b_value, :level_7_c_value, :level_7_d_value, :level_8_value, :level_8_increment, :level_8_a_value, :level_8_b_value, :level_8_c_value, :level_8_d_value, :level_9_value, :level_9_increment, :level_9_a_value, :level_9_b_value, :level_9_c_value, :level_9_d_value, :level_10_value, :level_10_increment, :level_10_a_value, :level_10_b_value, :level_10_c_value, :level_10_d_value)
    end
end
