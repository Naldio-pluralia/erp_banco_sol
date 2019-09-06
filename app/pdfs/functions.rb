class Functions < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper

  def initialize(functions, params, current, view_context)
    super(top_margin: 150)
    @functions = functions
    @params = params
    @current = current
    @view_context = view_context
    @setting = Setting.last
    draw
  end


  def draw
    cells = @functions.map do |e|
      [e.name,
       e.number]
    end
    cells = [['']] if cells.empty?

    table(cells,
          position: 0,
          :column_widths => [200, 340],
          :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}, row_colors: ["ffffff", "eeeeee"]) do
      column(6).style(:align => :right)
    end
    i = 0
    page_count.times do |i|
      go_to_page(i+1)
      # Headers
      bounding_box([0, bounds.height + 36], :width => 540, :height => 38) do
        table([[I18n.t(:functions)], [I18n.t('function.name'), I18n.t('function.number')]],
              position: 0,
              :column_widths => [200, 340],
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