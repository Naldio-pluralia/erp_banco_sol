class PdfSelfAssessmentFile < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper
  include PdfHelper

  def initialize(employee, assessment, view_context)
    super(top_margin: 255, bottom_margin: 100)
    @employee = employee
    @assessment = assessment
    return if assessment.nil?
    #@employee_goals = @assessment.employee_goals.where(employee_id: employee.id) # vinha da antiga tabela
    @employee_goals = @employee.get_function_employee_skills.includes(:skill).sort_by{|s| s.skill.name}
    @position = employee.efective_position
    @department = @position&.department
    @function = @position&.function
    @setting = Setting.last

    employee_goals_list
    header
  end

  def header
    i = 0
    page_count.times do |i|
      go_to_page(i+1)

      bounding_box([0, bounds.height + 223], :width => 540, :height => 72) do
        # stroke_bounds
        logotipo = @setting.entity_logo ? @setting.entity_logo_url.to_s : "#{Rails.root}/app/assets/images/bancosol-logo.png"

        if Rails.env.development? || Rails.env.test? # Tese para os ambientes
          if (@setting.entity_logo.present?)
            image "#{Rails.root}/public#{logotipo}", :position => :left, :width => 130
          else
            image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
          end
        else
          if (@setting.entity_logo.present?)
            image "/home/deploy/nextbss/shared/public#{logotipo}", :position => :left, :width => 130
          else
            image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
          end
        end
      end

      table([["#{pdf_t("self_assessment_file")}"]], position: 0, :column_widths => [540], :cell_style =>  {:borders => [], align: :center, :size => 9, :font_style => :bold})

      table([["#{pdf_t("self_assessed_id")}"]], position: 0, :column_widths => [540], :cell_style =>  {:borders => [], align: :center, :size => 9, :font_style => :bold})

      table([["#{pdf_t("name")}: #{@employee.full_name}", "#{pdf_t("employee_number")}: #{@employee.number || I18n.t('n/a')}"]],
        position: 0,
        :column_widths => [400, 140],
        :cell_style =>  {:borders => [], :align => :left, valign: :center, :size => 8, :font_style => :bold}) do
        row(0).style(height: 25)
        column(1).style(:align => :right)
      end

      table([["#{pdf_t("function.name")}: #{@function&.name || I18n.t('n/a')}", "#{pdf_t("department_name")}: #{@department&.name || I18n.t('n/a')}"]],
        position: 0,
        :column_widths => [270, 270],
        :cell_style =>  {:borders => [], :align => :left, valign: :center, :size => 8, :font_style => :bold}) do
        row(0).style(height: 25)
        column(1).style(:align => :right)
      end

      table([["#{pdf_t("self_assessment_factors")}"]], position: 0, :column_widths => [540], :cell_style =>  {:borders => [], align: :center, :size => 9, :font_style => :bold})

      table([["#{pdf_t("assessment_scale")}"]], position: 0, :column_widths => [540], :cell_style =>  {:borders => [], align: :center, :size => 9, :font_style => :bold})

      table([["#{pdf_t("skill")}", "#{pdf_t("short.self_assessment")}"]],
        position: 0,
        :column_widths => [500, 40],
        :cell_style =>  {:border_width => 0.0001, :align => :left, :size => 8,:font_style => :bold, text_color: text_header_color,background_color: table_header_color })do
        column(1).style(:align => :center)
      end
      bounding_box([0, bounds.bottom - 30], :width => bounds.width, :height => 30) do
        table([["#{pdf_t('self_assessed_signature')}: ____________________________________", "#{pdf_t('assessment_date')}: ____/_____/________"]],
          position: 0,
          :column_widths => [420, 120],
          :cell_style => {:border_width => 0, :borders => [], :align => :left, :size => 8})do
          column(1).style(:align => :right)
        end

      end
      bounding_box([515, bounds.bottom - 40], :width => bounds.width, :height => 30) { text I18n.t('x_of_y', x: i + 1, y: page_count), size: 9, :valign => :bottom }
    end
  end

  def employee_goals_list
    data = []

    @employee_goals.each do |f|
      if f.self_assessment > 0
        data << [f.skill.name, f.self_assessment]
      else
        data << [f.skill.name, '']
      end
    end
    return unless data.present?

    table(data,
      position: 0,
      :column_widths => [500, 40],
      :cell_style => {:border_width => 0.0001, :borders => [:right, :left, :bottom], :align => :left, :size => 6}) do
        column(1).style(:align => :center)
      end

    move_down 8



  end
end
