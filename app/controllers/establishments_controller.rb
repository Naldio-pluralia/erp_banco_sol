    class EstablishmentsController < ApplicationController
    before_action :set_establishment, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource

    # GET /establishments
    def index
      @establishments = Establishment.all
      respond_to do |f|
        f.json { render json: @establishments}
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /establishments/1
    def show
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /establishments/new
    def new
      @establishment = Establishment.new
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # GET /establishments/1/edit
    def edit
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # POST /establishments
    def create
      @establishment = Establishment.new(establishment_params)
      respond_to do |f|
        if @establishment.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @establishment.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /establishments/1
    def update
      respond_to do |f|
        if @establishment.update(establishment_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @establishment.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end

    # DELETE /establishments/1
    def destroy
      @establishment.destroy

      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_establishment
        @establishment = Establishment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def establishment_params
        params.require(:establishment).permit(:establishment_type_id, :municipality_id, :name, :code, :abbreviation, :inaugurated_at, :atm_count, :tpa_count, :status, :establishment_id)
      end
  end
