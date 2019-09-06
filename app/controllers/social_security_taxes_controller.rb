class SocialSecurityTaxesController < ApplicationController
  before_action :set_social_security_tax, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource

  # # GET /social_security_taxes
  # def index
  #   @social_security_taxes = SocialSecurityTax.all
  #   # @social_security_tax = SocialSecurityTax.new
  # end

  # # GET /social_security_taxes/1
  # def show
  # end

  # GET /social_security_taxes/new
  def new
    @social_security_tax = SocialSecurityTax.new
  end

  # GET /social_security_taxes/1/edit
  def edit
  end

  # POST /social_security_taxes
  def create
    @social_security_tax = SocialSecurityTax.new(social_security_tax_params)

    if @social_security_tax.save
      redirect_to latest_social_security_tax_url, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /social_security_taxes/1
  def update
    @social_security_tax = @social_security_tax.dup
    @social_security_tax.assign_attributes(social_security_tax_params)
    if @social_security_tax.save
      redirect_to latest_social_security_tax_url, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /social_security_taxes/1
  def destroy
    @social_security_tax.destroy
    redirect_to latest_social_security_tax_url, notice: t('.success')
  end

  def latest
    @social_security_tax = SocialSecurityTax.latest || SocialSecurityTax.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_security_tax
      @social_security_tax = SocialSecurityTax.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def social_security_tax_params
      params.require(:social_security_tax).permit(:name, :abbr_name, :percentage, :percentage_from_employee, :percentage_from_employer, :status)
    end
end
