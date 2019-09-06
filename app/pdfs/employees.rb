class Employees < Prawn::Document
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper

  def initialize(employees, params, current, view_context)
    super(top_margin: 150)
    @employees = employees
    @params = params
    @current = current
    @view_context = view_context
    @setting = Setting.last
    draw
  end


  def draw


    cells = @employees.map do |e|
      [e.first_and_last_name, e.number, e.status, e.level, e.paygrade]
    end

    cells = [['']] if cells.empty?

    table(cells,
          position: 0,
          :column_widths => [220, 100, 60, 90, 70],
          :cell_style => {:border_width => 0.001, :borders => [], :align => :left, :size => 6}, row_colors: ["ffffff", "eeeeee"]) do
      column(6).style(:align => :right)
    end
    page_count.times do |i|
      go_to_page(i+1)
      # Logos
      prawn_header(Setting.last)
      # Headers
      bounding_box([0, bounds.height + 36], :width => 540, :height => 38) do
        table([[I18n.t(:employees)], [I18n.t('employee_name'), I18n.t('employee_number'), I18n.t('status'), I18n.t('employee_paygrade_level'), I18n.t('employee_paygrade')]],
              position: 0,
              :column_widths => [220, 100, 60, 90, 70],
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
