class Positions < Prawn::Document
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper

  def initialize(positions, params, current, view_context)
    super(top_margin: 150)
    @positions = positions
    @employees_map = Employee.all.index_by(&:id)
    @functions_map = Function.all.index_by(&:id)
    @departments_map = Department.all.index_by(&:id)
    @positions_map = Position.all.index_by(&:id)
    @params = params
    @current = current
    @view_context = view_context
    @setting = Setting.last
    draw
  end


  def draw
    cells = @positions.map do |e|
      [e.name,
       e.number,
       @employees_map[e.efective_id]&.name_and_number,
       @departments_map[e.department_id]&.name,
       @positions_map[e.position_id]&.name]
    end
    cells = [['']] if cells.empty?

    table(cells,
          position: 0,
          :column_widths => [100, 60, 180, 100, 100],
          :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}, row_colors: ["ffffff", "eeeeee"]) do
      column(6).style(:align => :right)
    end
    i = 0
    page_count.times do |i|
      go_to_page(i+1)
      # Logos
      prawn_header(Setting.last)
      # Headers
      bounding_box([0, bounds.height + 36], :width => 540, :height => 38) do
        table([[I18n.t(:positions)], [I18n.t('position_name'), I18n.t('position.number'), I18n.t('employee_name'), I18n.t('department_name'), I18n.t('position.supervisor')]],
              position: 0,
              :column_widths => [100, 60, 180, 100, 100],
              :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}) do
          row(0).style(background_color: 'FFFFFF', text_color: 'fab033', size: 9)
          row(1).style(background_color: 'fab033', text_color: 'FFFFFF')
        end
      end
      # Page Numbers
      bounding_box([515, bounds.bottom + 14], :width => bounds.width, :height => 30) {
        text I18n.t('x_of_y', x: i + 1, y: page_count), size: 9, :valign => :bottom }
    end
  end

end