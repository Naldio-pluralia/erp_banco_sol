class QuestionOptionsController < ApplicationController
  before_action :set_question_option, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /question_options
  def index
    @question_options = QuestionOption.all
    @question_option = QuestionOption.new
    @question_option.cancel_and_redirect_url_to(question_options_url)
    respond_to do |f|
      f.html
      f.json { render json: @question_options.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /question_options/1
  def show
    @question_option.cancel_and_redirect_url_to(question_option_url(@question_option))
    respond_to do |f|
      f.html
      f.json { render json: @question_option.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /question_options/new
  def new
    @question_option = QuestionOption.new
    @question_option.cancel_url = question_options_url
    respond_to do |f|
      f.html
      f.json { render json: @question_option.as_json}
      f.js
    end
  end

  # GET /question_options/1/edit
  def edit
    @question_option.cancel_and_redirect_url_to(question_option_url(@question_option))
    respond_to do |f|
      f.html
      f.json { render json: @question_option.as_json}
      f.js
    end
  end

  # POST /question_options
  def create
    @question_option = QuestionOption.new(question_option_params)
    respond_to do |f|
      if @question_option.save
        f.html { redirect_to @question_option.redirect_url || redirect_url || question_option_url(@question_option), notice: controller_t('.saved') }
        f.json { render json: @question_option.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @question_option.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /question_options/1
  def update
    respond_to do |f|
      if @question_option.update(question_option_params)
        f.html { redirect_to @question_option.redirect_url || redirect_url || question_option_url(@question_option), notice: controller_t('.updated') }
        f.json { render json: @question_option.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @question_option.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /question_options/1
  def destroy
    @question_option.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || question_options_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_option
      @question_option = QuestionOption.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_option_params
      params.require(:question_option).permit(:question_id, :status, :option, :cancel_url, :redirect_url)
    end
end
