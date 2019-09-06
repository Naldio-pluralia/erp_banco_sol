class DetailsEmployee < Prawn::Document
  include PdfHelper

  def initialize(employee, assessment , view)
    super(top_margin: 45)
    @view = view
    @employee = employee
    @assessment = assessment

    transparent(0.5) { stroke_bounds }

    header
    move_down 0
    header_info_employee



  end

  private
    def header
      entity_logo
      info_employee
      # avatar_employee
    end

    def info_employee
      bounding_box([100, cursor + 80], :width => 130, :height => 80) do
        transparent(0.5) { stroke_bounds }

        indent(0) do
          formatted_text [{:text => "#{@employee.full_name}", :styles => [], :size =>9 }]
          move_down 3
          formatted_text [{:text => "#{@employee.efective_position&.name&.mb_chars&.to_s&.upcase || 'n/d'.ts}", :styles => [], :size =>9 }]
          move_down 3
          formatted_text [{:text => "#{@employee.number}", :styles => [], :size =>9 }]
        end
      end

      bounding_box([230, cursor + 80], :width => 80, :height => 80) do
        transparent(0.5) { stroke_bounds }
        indent(0) do
          formatted_text [{:text => "employee_paygrade_level".ts, :styles => [:bold], :size =>9 },{:text => ": #{@employee.paygrade}",  :styles => [:italic], :size =>8 }]
        end
      end

      bounding_box([310, cursor + 80], :width => 80, :height => 80) do
        transparent(0.5) { stroke_bounds }
        indent(0) do
          formatted_text [{:text => "employee_paygrade".ts, :styles => [:bold], :size =>9 },{:text => ": #{@employee.level}",  :styles => [:italic], :size =>8 }]
        end
      end

      bounding_box([420, cursor + 80], :width => 120, :height => 80) do
        transparent(0.5) { stroke_bounds }
        indent(0) do
          formatted_text [{:text => "#{'final_assessment'.ts}: ", :styles => [:bold], :size =>9 }, {:text => " #{@assessment&.present? ? @assessment.employee_assessment(@employee) : 'n/a'.ts}", :styles => [:italic], :size =>20, :align => :right}]
        end
      end



    end




    def header_info_employee
      table([["employee.employee_info".ts]],
        position: 0,
        :column_widths => [540],
        :cell_style =>  {:text_color => text_header_color, :font_style => :bold,:background_color => table_header_color, :borders => [], :align => :left, :size => 12}
      )
    end





end
