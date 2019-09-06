    class OrganicUnitsController < ApplicationController
    before_action :set_organic_unit, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource

    # GET /organic_units
    def index
      @organic_units = OrganicUnit.all
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /organic_units/1
    def show
      respond_to do |f|
        f.json { render }
        f.js{ render }
        f.xls{ render }
        f.pdf{ render }
      end
    end

    # GET /organic_units/new
    def new
      @organic_unit = OrganicUnit.new
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # GET /organic_units/1/edit
    def edit
      respond_to do |f|
        f.json{ render }
        f.js{ render }
      end
    end

    # POST /organic_units
    def create
      @organic_unit = OrganicUnit.new(organic_unit_params)
      respond_to do |f|
        if @organic_unit.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @organic_unit.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /organic_units/1
    def update
      respond_to do |f|
        if @organic_unit.update(organic_unit_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @organic_unit.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end

    # DELETE /organic_units/1
    def destroy
      @organic_unit.destroy

      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_organic_unit
        @organic_unit = OrganicUnit.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def organic_unit_params
        params.require(:organic_unit).permit(:organic_unit_type_id, :name, :abbreviation, :organic_unit_id)
      end
  end
