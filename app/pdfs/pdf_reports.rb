class PdfReports < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper
  include PdfHelper

  def initialize(view_context, charts = {})
    #charts keys [employee_goals_by_date_chart, completion_by_dep_chart, department_average_radar_chart, department_average_h_bar_chart, company_average_radar_chart, company_average_h_bar_chart]
    super(top_margin: 100, page_layout: :landscape, page_size: 'A4')
    setting = Setting.last

    if charts['employee_goals_by_date_chart'].present?
      image charts['employee_goals_by_date_chart'], position: :left, width: 760
    end

    if charts['completion_by_dep_chart'].present?
      image charts['completion_by_dep_chart'], position: :left, width: 760
    end

    if charts['department_average_h_bar_chart'].present?
      image charts['department_average_h_bar_chart'], position: :left, width: 760
    end

    if charts['department_average_radar_chart'].present?
      image charts['department_average_radar_chart'], position: :center, width: 430
    end

    if charts['company_average_h_bar_chart'].present?
      image charts['company_average_h_bar_chart'], position: :left, width: 760
    end

    if charts['company_average_radar_chart'].present?
      image charts['company_average_radar_chart'], position: :center, width: 430
    end



    page_count.times do |i|
      go_to_page(i+1)
      # Logos
      bounding_box([0, bounds.height + 79], :width => 720, :height => 72) do
        # stroke_bounds
        logotipo = setting.entity_logo ? setting.entity_logo_url.to_s : "#{Rails.root}/app/assets/images/bancosol-logo.png"

        if Rails.env.development? || Rails.env.test? # Tese para os ambientes
          if (setting.entity_logo.present?)
            image "#{Rails.root}/public#{logotipo}", :position => :left, :width => 130
          else
            image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
          end
        else
          if (setting.entity_logo.present?)
            image open("/home/deploy/nextbss/shared/public#{logotipo}"), :position => :left, :width => 130
          else
            image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
          end
        end
        text 'Relatórios', size: 14, :valign => :bottom, align: :center
      end
      # Page Numbers
      bounding_box([735, bounds.bottom + 14], :width => bounds.width, :height => 30) {
        text I18n.t('x_of_y', x: i + 1, y: page_count), size: 9, :valign => :bottom}
    end
  end
end
