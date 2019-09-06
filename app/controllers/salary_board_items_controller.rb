class SalaryBoardItemsController < ApplicationController
  before_action :set_salary_board_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # GET /salary_board_items
  def index
    @salary_board_items = SalaryBoardItem.all
    # @salary_board_item = SalaryBoardItem.new
  end

  # GET /salary_board_items/1
  def show
  end

  # GET /salary_board_items/new
  def new
    @salary_board_item = SalaryBoardItem.new
  end

  # GET /salary_board_items/1/edit
  def edit
  end

  # POST /salary_board_items
  def create
    @salary_board_item = SalaryBoardItem.new(salary_board_item_params)

    if @salary_board_item.save
      redirect_to @salary_board_item, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /salary_board_items/1
  def update
    if @salary_board_item.update(salary_board_item_params)
      redirect_to @salary_board_item, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /salary_board_items/1
  def destroy
    @salary_board_item.destroy
    redirect_to salary_board_items_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_board_item
      @salary_board_item = SalaryBoardItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salary_board_item_params
      params.require(:salary_board_item).permit(:paygrade, :base_value, :increment_value, :a_value, :b_value, :c_value, :d_value, :salary_board_id)
    end
end
