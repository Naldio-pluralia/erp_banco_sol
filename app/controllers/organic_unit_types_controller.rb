    class OrganicUnitTypesController < ApplicationController
    before_action :set_organic_unit_type, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource

    # GET /organic_unit_types
    def index
      @organic_unit_types = OrganicUnitType.all
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /organic_unit_types/1
    def show
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /organic_unit_types/new
    def new
      @organic_unit_type = OrganicUnitType.new
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # GET /organic_unit_types/1/edit
    def edit
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # POST /organic_unit_types
    def create
      @organic_unit_type = OrganicUnitType.new(organic_unit_type_params)
      respond_to do |f|
        if @organic_unit_type.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @organic_unit_type.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /organic_unit_types/1
    def update
      respond_to do |f|
        if @organic_unit_type.update(organic_unit_type_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @organic_unit_type.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end

    # DELETE /organic_unit_types/1
    def destroy
      @organic_unit_type.destroy

      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_organic_unit_type
        @organic_unit_type = OrganicUnitType.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def organic_unit_type_params
        params.require(:organic_unit_type).permit(:name)
      end
  end
