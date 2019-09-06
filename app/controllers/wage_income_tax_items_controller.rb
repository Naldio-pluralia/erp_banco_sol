# class WageIncomeTaxItemsController < ApplicationController
#   before_action :set_wage_income_tax_item, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_account!
#   load_and_authorize_resource

#   # GET /wage_income_tax_items
#   def index
#     @wage_income_tax_items = WageIncomeTaxItem.all
#     # @wage_income_tax_item = WageIncomeTaxItem.new
#   end

#   # GET /wage_income_tax_items/1
#   def show
#   end

#   # GET /wage_income_tax_items/new
#   def new
#     @wage_income_tax_item = WageIncomeTaxItem.new
#   end

#   # GET /wage_income_tax_items/1/edit
#   def edit
#   end

#   # POST /wage_income_tax_items
#   def create
#     @wage_income_tax_item = WageIncomeTaxItem.new(wage_income_tax_item_params)

#     if @wage_income_tax_item.save
#       redirect_to @wage_income_tax_item, notice: t('.success')
#     else
#       render :new
#     end
#   end

#   # PATCH/PUT /wage_income_tax_items/1
#   def update
#     if @wage_income_tax_item.update(wage_income_tax_item_params)
#       redirect_to @wage_income_tax_item, notice: t('.success')
#     else
#       render :edit
#     end
#   end

#   # DELETE /wage_income_tax_items/1
#   def destroy
#     @wage_income_tax_item.destroy
#     redirect_to wage_income_tax_items_url, notice: t('.success')
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_wage_income_tax_item
#       @wage_income_tax_item = WageIncomeTaxItem.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def wage_income_tax_item_params
#       params.require(:wage_income_tax_item).permit(:wage_income_tax_id, :from, :to, :fixed_portion, :percentage_over_the_excess, :excess_of, :status)
#     end
# end
