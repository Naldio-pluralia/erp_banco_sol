    class EstablishmentTypesController < ApplicationController
    before_action :set_establishment_type, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource

    # GET /establishment_types
    def index
      @establishment_types = EstablishmentType.all
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /establishment_types/1
    def show
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /establishment_types/new
    def new
      @establishment_type = EstablishmentType.new
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # GET /establishment_types/1/edit
    def edit
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # POST /establishment_types
    def create
      @establishment_type = EstablishmentType.new(establishment_type_params)
      respond_to do |f|
        if @establishment_type.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @establishment_type.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /establishment_types/1
    def update
      respond_to do |f|
        if @establishment_type.update(establishment_type_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @establishment_type.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end

    # DELETE /establishment_types/1
    def destroy
      @establishment_type.destroy

      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_establishment_type
        @establishment_type = EstablishmentType.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def establishment_type_params
        params.require(:establishment_type).permit(:name)
      end
  end
