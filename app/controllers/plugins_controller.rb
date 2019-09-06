class PluginsController < ApplicationController
  before_action :authenticate_account!
  load_and_authorize_resource
  before_action :set_plugin, only: [:show, :edit, :update, :destroy]

  # GET /plugins
  # GET /plugins.json
  def index
    @plugins = Plugin.all
  end

  # GET /plugins/1
  # GET /plugins/1.json
  def show
  end

  # GET /plugins/new
  def new
    @plugin = Plugin.new
  end

  # GET /plugins/1/edit
  def edit
  end

  # POST /plugins
  # POST /plugins.json
  def create
    @plugin = Plugin.new(plugin_params)

    respond_to do |format|
      if @plugin.save
        format.html { redirect_to @plugin, notice: 'register_was_successfully_created'.ts }
        format.json { render :show, status: :created, location: @plugin }
      else
        format.html { render :new }
        format.json { render json: @plugin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plugins/1
  # PATCH/PUT /plugins/1.json
  def update
    respond_to do |format|
      if @plugin.update(plugin_params)
        format.html { redirect_to @plugin, notice: 'register_was_successfully_updated'.ts }
        format.json { render :show, status: :ok, location: @plugin }
      else
        format.html { render :edit }
        format.json { render json: @plugin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plugins/1
  # DELETE /plugins/1.json
  def destroy
    @plugin.destroy
    respond_to do |format|
      format.html { redirect_to plugins_url, notice: 'register_was_successfully_destroyed'.ts }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plugin
      @plugin = Plugin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plugin_params
      params.require(:plugin).permit(:name, :description, :is_active, :version, :parent_id, :url, :if_can, :order, :icon)
    end
end
