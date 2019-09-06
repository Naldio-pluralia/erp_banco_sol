class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  load_and_authorize_resource
  layout :resolve_layout

  # GET /questions
  def index
    @questions = Question.all
    @question = Question.new
    @question.cancel_and_redirect_url_to(questions_url)
    respond_to do |f|
      f.html
      f.json { render json: @questions.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /questions/1
  def show
    @question.cancel_and_redirect_url_to(question_url(@question))
    respond_to do |f|
      f.html
      f.json { render json: @question.as_json}
      f.js
      f.xls
      f.pdf
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.cancel_url = questions_url
    respond_to do |f|
      f.html
      f.json { render json: @question.as_json}
      f.js
    end
  end

  # GET /questions/1/edit
  def edit
    @question.cancel_and_redirect_url_to(question_url(@question))
    respond_to do |f|
      f.html
      f.json { render json: @question.as_json}
      f.js
    end
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    respond_to do |f|
      if @question.save
        if @question.boolean_question?
          if @question.boolean_option
            QuestionOption.create([{question_id: @question.id, option: 'Verdadeira', status:  :correct}, {question_id: @question.id, option: 'Falsa', status:  :incorrect}] )
          else
            QuestionOption.create([{question_id: @question.id, option: 'Verdadeira', status:  :incorrect}, {question_id: @question.id, option: 'Falsa', status:  :correct}] )
          end
        end
        f.html { redirect_to @question.redirect_url || redirect_url || question_url(@question), notice: controller_t('.saved') }
        f.json { render json: @question.as_json}
        f.js { render :show }
      else
        f.html { render :new }
        f.json { render json: @question.errors, status: :unprocessable_entity }
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  def update
    respond_to do |f|
      if @question.update(question_params)
        f.html { redirect_to @question.redirect_url || redirect_url || question_url(@question), notice: controller_t('.updated') }
        f.json { render json: @question.as_json}
        f.js { render :show }
      else
        f.html { render :edit }
        f.json { render json: @question.errors, status: :unprocessable_entity }
        f.js { render :edit }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    
    respond_to do |f|
      f.html { redirect_to redirect_url || questions_url, notice: controller_t('.destroyed') }
      f.json { head :no_content }
      f.js { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:exam_id, :number, :description, :kind, :value, :boolean_option, :cancel_url, :redirect_url)
    end
end
