    class MunicipalitiesController < ApplicationController
    before_action :set_municipality, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource

    # GET /municipalities
    def index
      @municipalities = Municipality.all
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /municipalities/1
    def show
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /municipalities/new
    def new
      @municipality = Municipality.new
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # GET /municipalities/1/edit
    def edit
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # POST /municipalities
    def create
      @municipality = Municipality.new(municipality_params)
      respond_to do |f|
        if @municipality.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @municipality.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /municipalities/1
    def update
      respond_to do |f|
        if @municipality.update(municipality_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @municipality.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end

    # DELETE /municipalities/1
    def destroy
      @municipality.destroy

      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_municipality
        @municipality = Municipality.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def municipality_params
        params.require(:municipality).permit(:name, :province_id)
      end
  end
