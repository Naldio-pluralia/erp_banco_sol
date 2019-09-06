module Nextsgad
  class FunctionsController < NextSgad::FunctionsController
    before_action :authenticate_account!
    load_and_authorize_resource class: Function
    before_action :set_function, only: [:show, :edit, :update, :destroy, :toogle_area, :toogle_contract_type, :toogle_autonomy, :toogle_qualification_kind, :toogle_experience_kind]

    # GET /functions
    def index
      @function = Function.new
      @upload = Upload.new(type: 'functions')
      @functions = Function.all
      respond_to do |format|
        format.html
        format.json{render json: @functions}
        format.xls do
          # TODO send this data block to a file
          # TODO check between xls.erb and rb to do so
          book = Spreadsheet::Excel::Workbook.new

          sheet = book.create_worksheet name: I18n.t(:employees)
          sheet.row(0).concat [I18n.t('functions')]
          sheet.row(1).concat [I18n.t('name'), I18n.t('number')]
          @functions.each_with_index do |f, index|
            sheet.row(2 + index).concat [f.name, f.number]
          end

          file_contents = StringIO.new
          book.write file_contents
          send_data file_contents.string, filename: "#{I18n.t('functions')}.xls", :type => "application/vnd.ms-excel"
        end
        format.pdf do
          send_data Functions.new(@functions, params, current, view_context).render, filename: "#{t :functions}.pdf", type: 'application/pdf', disposition: 'inline'
        end
      end
    end

    # GET /functions/1
    def show
    end

    # GET /functions/new
    def new
      @function = Function.new
    end

    # GET /functions/1/edit
    def edit
    end

    # POST /functions
    def create
      @function = Function.new(function_params)

      if @function.save
        redirect_to functions_url, notice: 'register_was_successfully_created'.ts
      else
        render :new
      end
    end

    # PATCH/PUT /functions/1
    def update
      respond_to do |f|
        if @function.update(function_params)
          f.html{redirect_to @function, notice: 'register_was_successfully_updated'.ts}
          f.json { render json: @function.as_json}
          f.js{render resolve_render(:show)}
          f.xls
          f.pdf
        else
          f.html{render :edit }
          f.json { render json: @function.errors, status: :unprocessable_entity }
          f.js{render resolve_render(:show)}
          f.xls
          f.pdf
        end
      end
    end

    # DELETE /functions/1
    def destroy
      @function.destroy
      redirect_to functions_url, notice: 'register_was_successfully_destroyed'.ts
    end

    def settings
      respond_to do |f|
        f.html
        f.js
        f.xls
        f.pdf
      end
    end

    def toogle_area
      function_area = FunctionArea.find(params[:function_area_id])
      if @function.function_areas.map(&:id).include?(function_area.id)
        @function.update(function_area_ids: @function.function_area_ids - [function_area.id])
      else
        @function.update(function_area_ids: @function.function_area_ids + [function_area.id])
      end
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    def toogle_autonomy
      function_autonomy_level = FunctionAutonomyLevel.find(params[:function_autonomy_level_id])
      if @function.function_autonomy_levels.map(&:id).include?(function_autonomy_level.id)
        @function.update(function_autonomy_level_ids: @function.function_autonomy_level_ids - [function_autonomy_level.id])
      else
        @function.update(function_autonomy_level_ids: @function.function_autonomy_level_ids + [function_autonomy_level.id])
      end
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    def toogle_subsidy
      function_subsidy = FunctionSubsidy.find(params[:function_subsidy_id])
      if @function.function_subsidies.map(&:id).include?(function_subsidy.id)
        @function.update(function_subsidy_ids: @function.function_subsidy_ids - [function_subsidy.id])
      else
        @function.update(function_subsidy_ids: @function.function_subsidy_ids + [function_subsidy.id])
      end
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    def toogle_contract_type
      function_contract_type = FunctionContractType.find(params[:function_contract_type_id])
      if @function.function_contract_type_id == function_contract_type.id
        @function.update(function_contract_type_id: nil)
      else
        @function.update(function_contract_type_id: function_contract_type.id)
      end
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    def toogle_qualification_kind
      @function.update(qualification_kind: params[:qualification_kind])
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    def toogle_experience_kind
      @function.update(experience_kind: params[:experience_kind])
      respond_to do |f|
        f.html{redirect_to redirect_url || @function}
        f.json { render json: @function.as_json}
        f.js{render resolve_render(:show)}
        f.xls
        f.pdf
        f.text {render 'show.html.erb', layout: false, status: :ok}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_function
      @function = Function.includes(function_skills: [:skill]).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def function_params
      params.require(:function).permit(:enters_at, :leaves_at, :name, :description, :organic_unit_id, :experience_kind, :qualification_kind, :experience_years, :other_requirements, :objectives, :function_deslocation_regime_id, :directorate_id, {function_area_ids: [], function_autonomy_level_ids: [], function_subsidy_ids: []})
    end
  end
end
