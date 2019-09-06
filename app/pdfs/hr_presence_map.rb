class HrPresenceMap < PdfApplication
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper
  include PdfHelper

  def initialize(current, params, view_context)
    @margin_top = 137
    super(top_margin: @margin_top, bottom_margin: 50, page_layout: :landscape, page_size: 'A4')
    @current = current
    @params = params
    if params[:period].present?
      month, year = params[:period].split('/').last(2).map(&:to_i)
      @date = DateTime.new(year, month)
    else
      @date = DateTime.now
    end
    @employees = Employee.employee_id(params[:employee]).includes(:user).order(:number)
    @absences = {}
    AbsenceDay.all.includes(:employee_absence).each{|f| @absences[[f.employee_absence.employee_id, f.date.day, f.date.month, f.date.year]] ||= "F#{f.employee_absence&.has_justification? ? f.employee_absence&.letter : ""}" } if params[:kind].blank? || params[:kind].includes?('absences', 'all')
    EmployeeDelay.all.each{|e| @absences[[e.employee_id, e.arrived_at.day, e.arrived_at.month, e.arrived_at.year]] ||= "A#{e&.has_justification? ? e&.letter : ""}"} if (params[:kind].blank? || params[:kind].includes?('delays', 'all'))
    EmployeeExit.all.index_by{|e| @absences[[e.employee_id, e.date.day, e.date.month, e.date.year]] ||= "S#{e&.has_justification? ? e&.letter : ""}" } if (params[:kind].blank? || params[:kind].includes?('exits', 'all'))
    EmployeePresence.where(employee_id: @employees.ids).each{|f| @absences[[f.employee_id, f.date.day, f.date.month, f.date.year]] ||= "P-#{f.status}" } if params[:kind].blank? || params[:kind].includes?('presences', 'all')
    VacationDay.all.includes(:employee_vacation).select{|v| v.approved? || v.pending?}.each{|e| @absences[[e.employee_vacation.employee_id, e.date.day, e.date.month, e.date.year]] ||= "V#{e.employee_vacation.letter}" } if params[:kind].blank? || params[:kind].includes?('vacations', 'all')
    @setting = Setting.last
    @borders = [:top, :bottom, :left, :right]

    presences
    header
  end

  def header
    i = 0
    page_count.times do |i|
      go_to_page(i+1)

      bounding_box([0, bounds.height + @margin_top - 25], :width => 769, :height => 72) do
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
      table([[I18n.l(@date, format: 'Presenças de %B de %Y')]], position: 0, column_widths: [769], cell_style:  {borders: [], align: :center, size: 9, font_style: :bold})
      days = ['Colaborador']
      widths = []
      (1..@date.n_days_in_month).each do |n|
        days << n.to_s.rjust(2, '0')
        widths << 18
      end
      widths = [769 - widths.sum] + widths
      table([days], position: 0, column_widths: widths, cell_style:  {borders: @borders, align: :left, size: 8, font_style: :bold})
      bounding_box([750, bounds.bottom + 14], :width => bounds.width, :height => 30) {
        text I18n.t('x_of_y', x: i + 1, y: page_count), size: 9, :valign => :bottom}
    end
  end

  def presences
    trunc = 44
    if @date.n_days_in_month == 30
      trunc = 49
    elsif @date.n_days_in_month == 29
      trunc = 54
    elsif @date.n_days_in_month == 28
      trunc = 58
    end
    @employees.each do |f|
      days = [f.name_and_number.truncate(trunc)]
      widths = []
      (1..@date.n_days_in_month).each do |n|
        day = @absences[[f.id, n, @date.month, @date.year]] || ''
        days << day.split('-').first
        widths << 18
      end
      widths = [769 - widths.sum] + widths
      table([days], position: 0, column_widths: widths, cell_style:  {borders: @borders, align: :left, size: 8, font_style: :bold, text_color: 'ffffff'}) do
        column(0).text_color = '000000'
        vacation_cells = cells.each{|cell| cell.background_color = '00b300' if cell.content.to_s == 'P'}
        vacation_cells = cells.each{|cell| cell.background_color = 'e65100' if cell.content.to_s == 'P-unconfirmed'}
        vacation_cells = cells.each{|cell| cell.background_color = '00b300' if cell.content.to_s == 'P-confirmed'}
        vacation_cells = cells.each{|cell| cell.background_color = 'fab230' if cell.content.to_s == 'A'}
        vacation_cells = cells.each{|cell| cell.background_color = 'fab230' if cell.content.to_s == 'S'}
        vacation_cells = cells.each{|cell| cell.background_color = 'ff0000' if cell.content.to_s == 'F'}
        vacation_cells = cells.each{|cell| cell.background_color = '0000ff' if cell.content.to_s == 'V'}

        vacation_cells = cells.each{|cell| cell.background_color = '757575' if cell.content.to_s == 'Ae'}
        vacation_cells = cells.each{|cell| cell.background_color = '69f0ae' if cell.content.to_s == 'Ab'}
        vacation_cells = cells.each{|cell| cell.background_color = 'ff6e40' if cell.content.to_s == 'An'}

        vacation_cells = cells.each{|cell| cell.background_color = '757575' if cell.content.to_s == 'Se'}
        vacation_cells = cells.each{|cell| cell.background_color = '69f0ae' if cell.content.to_s == 'Sb'}
        vacation_cells = cells.each{|cell| cell.background_color = 'ff6e40' if cell.content.to_s == 'Sn'}

        vacation_cells = cells.each{|cell| cell.background_color = '757575' if cell.content.to_s == 'Fe'}
        vacation_cells = cells.each{|cell| cell.background_color = '69f0ae' if cell.content.to_s == 'Fb'}
        vacation_cells = cells.each{|cell| cell.background_color = 'ff6e40' if cell.content.to_s == 'Fn'}

        vacation_cells = cells.each{|cell| cell.background_color = '757575' if cell.content.to_s == 'Ve'}
        vacation_cells = cells.each{|cell| cell.background_color = '69f0ae' if cell.content.to_s == 'Vb'}
        vacation_cells = cells.each{|cell| cell.background_color = 'ff6e40' if cell.content.to_s == 'Vn'}
      end
    end
  end
end
