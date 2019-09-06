class AssessmentsMap < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper
  include PdfHelper

  def initialize(employees, employees_assessments, view_context)
    super(top_margin: 150)
    @employees = employees.can_be_assessed.where(id: employees_assessments.map(&:first))
    @employees_assessments = employees_assessments
    @departments_by_id = Department.all.index_by(&:id)
    @position_by_efective = Position.all.index_by(&:efective_id)
    @view_context = view_context
    @setting = Setting.last

    assessments_list
    header
  end

  def header
    i = 0
    page_count.times do |i|
      go_to_page(i+1)

        # table([["assessment.map".ts]],
        # position: 0,
        # :column_widths => [540],
        # :cell_style =>  {text_color: text_header_color, :font_style => :bold,background_color: table_header_color, :borders => [], :align => :center, :size => 10})

        table([[ 'employee_number'.ts, 'employee_name'.ts, 'employee_paygrade'.ts, 'department_name'.ts, 'short.self_assessment'.ts, 'short.supervisor_assessment'.ts, 'short.final_assessment'.ts]],
        position: 0,
        :column_widths => [100, 120, 80, 150, 30, 30, 30],
        :cell_style =>  {:border_width => 0.001, :borders => [:bottom], :align => :left, :size => 8,:font_style => :bold, text_color: text_header_color,background_color: table_header_color })do
          column(2).style(:align => :center)
          column(4).style(:align => :center)
          column(5).style(:align => :center)
          column(6).style(:align => :center)
          column(7).style(:align => :center)
        end
      draw
    end
  end

  def assessments_list
    @employees.each do |employee|
      table([["#{employee.number}", "#{employee.first_and_last_name}", "#{employee.paygrade}", "#{@departments_by_id[@position_by_efective[employee.id]&.department_id]&.name || I18n.t('n/a')}",
              color_status(@employees_assessments[employee.id], :self),
              color_status(@employees_assessments[employee.id], :supervisor),
              color_status(@employees_assessments[employee.id], :final)]],
      position: 0,
      :column_widths => [100, 120, 80, 150, 30, 30, 30],
      :cell_style => {:border_width => 0.0001, :borders => [:right, :left, :bottom], :align => :left, :size => 6})do
        column(2).style(:align => :center)
        column(4).style(:align => :center)
        column(5).style(:align => :center)
        column(6).style(:align => :center)
        column(7).style(:align => :center)
      end

    end

  end











end
