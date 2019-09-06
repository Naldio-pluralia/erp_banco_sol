    class ProvincesController < ApplicationController
    before_action :set_province, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    # load_and_authorize_resource
  
    # GET /provinces
    def index
      @provinces = Province.all
    end
  
    # GET /provinces/1
    def show
    end
  
    # GET /provinces/new
    def new
      @province = Province.new
    end
  
    # GET /provinces/1/edit
    def edit
    end
  
    # POST /provinces
    def create
      @province = Province.new(province_params)
      respond_to do |f|
        if @province.save
          f.json { render :show}
          f.js { render :show }
        else
          f.json { render json: @province.errors, status: :unprocessable_entity }
          f.js { render :new, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /provinces/1
    def update
      respond_to do |f|
        if @province.update(province_params)
          f.json { render :show }
          f.js { render :show  }
        else
          f.json { render json: @province.errors, status: :unprocessable_entity }
          f.js { render :edit, status: :unprocessable_entity  }
        end
      end
    end
  
    # DELETE /provinces/1
    def destroy
      @province.destroy
  
      respond_to do |f|
        f.json { head :no_content }
        f.js { render  }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_province
        @province = Province.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def province_params
        params.require(:province).permit(:name)
      end
  end
    