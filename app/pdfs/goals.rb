class Goals < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper

  def initialize(goals, params, current, view_context)
    super(top_margin: 150)
    @goals = goals
    @params = params
    @current = current
    @view_context = view_context
    @setting = Setting.last
    draw
  end


  def draw
    cells = @goals.map do |e|
      if e.numeric?
      [e.name,
       I18n.t(e.goal_type),
       I18n.t(e.nature),
       "#{e.target} #{'e.unit'.ts}"]
      else
        [e.name,
         I18n.t(e.goal_type),
         I18n.t(e.nature),
         "-"]
      end

    end
    cells = [['']] if cells.empty?

    table(cells,
          position: 0,
          :column_widths => [240, 100, 100, 100],
          :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}, row_colors: ["ffffff", "eeeeee"]) do
      column(6).style(:align => :right)
    end
    i = 0
    page_count.times do |i|
      go_to_page(i+1)
      # Headers
      bounding_box([0, bounds.height + 36], :width => 540, :height => 38) do
        table([[I18n.t(:goals)], [I18n.t('goal.name'), I18n.t('goal.goal_type'), I18n.t('goal.nature'), I18n.t('goal.target')]],
              position: 0,
              :column_widths => [240, 100, 100, 100],
              :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}) do
          row(0).style(background_color: 'FFFFFF', text_color: 'fab033', size: 9)
          row(1).style(background_color: 'fab033', text_color: 'FFFFFF')
        end
      end
      # Page
      super
    end
  end

end
