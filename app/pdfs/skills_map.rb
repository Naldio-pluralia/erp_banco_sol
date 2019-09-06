class SkillsMap < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper
  include PdfHelper

  def initialize(employee_skills, view_context)
    super(top_margin: 150)
    @employee_skills = employee_skills
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
        move_up 20

        table([[ 'employee_number'.ts, 'employee_name'.ts, 'employee_paygrade'.ts, 'Posição - Unidade Orgânica', 'short.self_assessment'.ts, 'short.supervisor_assessment'.ts, 'short.final_assessment'.ts]],
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
    @employee_skills.each do |employee|
      table([[
        employee[0][:number],
        employee[0][:first_and_last_name],
        employee[0][:paygrade],
        employee[0][:establishment],
        employee[0][:self_assessment],
        employee[0][:supervisor_assessment],
        employee[0][:final_assessment]
        ]],
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
