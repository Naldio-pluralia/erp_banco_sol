module ApplicationHelper

  # def calculate_progress_bar(employee_goal) TODO descomentar esse metodo pra calcular o preogressbar com os resultados
  #   target_e = employee_goal.target
  #   amount_e = employee_goal.amount
  #   (100*amount_e)/target_e
  # end

  def description_states(value)
    v = value.round(2)

    if (1.0..1.49).include?(v) || (0..0.99).include?(v)
      "Mau"
    elsif (1.50..2.49).include?(v)
      "Insuficiente"
    elsif (2.50..3.49).include?(v)
      "Suficiente"
    elsif (3.50..4.49).include?(v)
      "Bom"
    elsif (4.50..5.0).include?(v)
      "Excelente"
    end
  end

  def next_auto_id
    @auto_id ||= 0
    @auto_id += 1
    "nextbss_id_#{@auto_id}"
  end

  def calculate_percentagem(total, value)
    return 0 if total == 0
    ((value.to_f/total) * 100).round(2)
  end

  def color_assessment_progressbar_self(assessment)
    total = assessment.skills_percentage + assessment.objectives_percentage + assessment.attendance_percentage
    all_assessment_employee = EmployeeGoal.self_assessment_count

    if all_assessment_employee > total || all_assessment_employee == total
      '#4caf50'
    elsif all_assessment_employee > 0 && all_assessment_employee < total
      '#fab033'
    else
      '#d50000'
    end
  end

  def color_assessment_progressbar_supervisor(assessment)
    total = assessment.skills_percentage + assessment.objectives_percentage + assessment.attendance_percentage
    all_assessment_employee = EmployeeGoal.supervisor_assessment_count

    if all_assessment_employee > total || all_assessment_employee == total
      '#4caf50' #Complete
    elsif all_assessment_employee > 0 && all_assessment_employee < total
      '#fab033' #Progress
    else
      '#d50000' #Nothing
    end
  end

  def color_assessment_progressbar_final(assessment)
    total = assessment.skills_percentage + assessment.objectives_percentage + assessment.attendance_percentage
    all_assessment_employee = EmployeeGoal.final_assessment_count

    if all_assessment_employee > total || all_assessment_employee == total
      '#4caf50'
    elsif all_assessment_employee > 0 && all_assessment_employee < total
      '#fab033'
    else
      '#d50000'
    end
  end


  def color_status_export_assessment(employee_assessment, type)

    if employee_assessment.nil?
      'status_default'
    elsif employee_assessment.send("#{type}_pending?")
      'status_pending'
    elsif employee_assessment.send("#{type}_in_progress?")
      'status_in_progress'
    elsif employee_assessment.send("#{type}_completed?")
      'status_completed'
    else
      'status_default'
    end
  end

  def assessment_text(value)
    return if value.nil?
    {5 => "Excelente", 4 => "Bom", 3 => "Suficiente", 2  => "Insuficiente", 1 => "Mau", 0 => "Mau"}[value]
  end


  #TODO Remover este metodo (Cabanga)
  def color_status_export(employee_assessment, type)
    if employee_assessment.nil?
      'status_default'
    elsif employee_assessment.send("#{type}_pending?")
      'status_pending'
    elsif employee_assessment.send("#{type}_in_progress?")
      'status_in_progress'
    elsif employee_assessment.send("#{type}_completed?")
      'status_completed'
    else
      'status_default'
    end
  end


  def color_status(employee_assessment, type)
    if employee_assessment.send("#{type}_pending?")
      {image: "#{Rails.root}/app/assets/images/red.png", scale: 0.16, position: :center, vposition: :center}

    elsif employee_assessment.send("#{type}_in_progress?")
      {image: "#{Rails.root}/app/assets/images/yellow.png", scale: 0.16, position: :center, vposition: :center}

    elsif employee_assessment.send("#{type}_completed?")
      {image: "#{Rails.root}/app/assets/images/green.png", scale: 0.16, position: :center, vposition: :center}

    else
      ''
    end
  end

  def attendances_status(attendance)
    if attendance.unjustified?
      '#d50000'
    elsif attendance.pending?
      '#fab033'
    elsif attendance.accepted?
      '#4caf50'
    elsif attendance.denied?
      '#d50000'
    end
  end

  def calculate_percentage_of_execution(employees, assessment)
    employees_assessmented = 0

    employees.each do |employee|
      final_note = assessment.employee_assessment(employee)
      employees_assessmented += final_note
    end

    total_assessment_val = assessment.skills_percentage + assessment.objectives_percentage + assessment.attendance_percentage
    percentage = ((employees_assessmented * 100)/total_assessment_val)

    return percentage
  end

  def count_employee(employees)
    t('count_employees', count: employees.count)
  end

  def exist_active?
    Assessment.where(status: 1).first
  end

  def calculate_progress_bar(final_assessment)
    (100*final_assessment)/5
  end

  def all_activities
    Activity.all
  end

  def resutls_employee_goal(employee_goal)
    Result.where(employee_goal_id: employee_goal.id)
  end

  # def first_and_last_name_employee(name)
  #   full_name = name.split(" ").map(&:to_s)
  #   f_name = full_name.first[0]
  #   l_name = full_name.last
  #
  #   return f_name+"." + " " + l_name
  # end

  # wil print an icon
  def icon(options = {})
    content = ""
    icon = options.delete(:icon).to_s.split('_at_')
    if icon.present?
      options[:"#{icon.pop}"] = icon.join('_at_')
    end

    if options[:gly_icon].present? || options[:gly].present?
      options[:class] = "#{options[:class]} glyphicon glyphicon-#{options.delete(:gly_icon) || options.delete(:gly)}".squeeze

    elsif options[:faw_icon].present? || options[:faw].present?
      options[:class] = "fa fa-#{options.delete(:faw_icon) || options.delete(:faw)} #{options[:class]}".squeeze

    elsif options[:mtl_icon].present? || options[:mtl].present?
      options[:class] = "material-icons #{options[:class]}".squeeze
      content = options.delete(:mtl_icon) || options.delete(:mtl)

    elsif options[:img_icon].present? || options[:img].present?
      return image_tag(options.delete(:img_icon) || options.delete(:img), options || {})
    end

    content_tag(:i, content, options)
  end

  #
  def modules
    @modules ||= Plugin.where.not(url: [nil, ''])
  end

  # Loads Configurations
  def configuration
    @config ||= Setting.last
  end

  # Loads the plugins
  def plugins
    @plugins ||= configuration.plugins
  end

  # creates a new dom id
  def generate_dom_id
    @dom_id = @dom_id + 1 rescue 1
    "rails-generated-id-#{(@dom_id)}"
  end

  # Creates a mdl tooltip
  def mdl_tooltip(content = nil, options = nil, &block)
    options ||= {}
    options.merge!({class: "mdl-tooltip #{options.delete(:class)}"})
    if block_given?
      content_tag(:div, options) do
        block.call
      end
    else
      content_tag(:div, content.to_s.html_safe, options)
    end
  end

  # creates a new current object
  def current
    @role ||= current_account&.role
    @current ||= Current.new(user: current_account, params: params.to_unsafe_h, role: current_account&.role)
  end

  # creates a instance of ability
  def current_ability
    @current_ability ||= Ability.new(current)
  end

  # Creates the org chart data
  def org_data(root, positions)
    data = {}
    # groups position by supervisor
    children = positions.group_by {|p| p.position_id}[root.id]
    # groups position by root supervisor
    sibling_num = (positions[root.position_id] || []).size - 1
    sibling_num = 0 if sibling_num < 0
    parent_num = root.position_id.present? ? 1 : 0
    data[:id] = root.id
    data[:name] = root.efective&.full_abbr_name || 'N/D'
    data[:avatar] = nil # TODO Ver o que se vai fazer com a foto
    data[:ocupation] = root.name
    data[:department] = root.department&.name || 'N/D'
    data[:level] = root.efective&.level || 'N/D'
    data[:paygrade] = root.efective&.paygrade || 'N/D'
    data[:department_id] = root.department&.id
    data[:employee_id] = root.efective&.id || 'N/D'
    data[:employee_number] = root.efective&.number || 'N/D'

    data[:children] = [] if children.size > 0
    children.each do |child|
      data[:children] << org_data(child, positions)
    end
    data[:relationship] = {children_num: children.size, sibling_num: sibling_num, parent_num: parent_num}
    data
  end

  # Writes page name
  def page_name(name)
    @page_name = name
  end

  def my_assessments_url
    employee_id = current.employee&.id
    if employee_id.present?
      my_data_url
    else
      root_url
    end
  end

  # get current signed in account
  def current_account
    if user_signed_in?
      current_user
    elsif admin_signed_in?
      current_admin
    end
  end

  # get current account session
  def account_session
    if user_signed_in?
      user_session
    elsif admin_signed_in?
      admin_session
    end
  end

  # chek if any user is signed_in
  def account_signed_in?
    user_signed_in? || admin_signed_in?
  end

  # Authenticate current signed_in account
  def authenticate_account!
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_user!
    end
  end

  # sets url to redirect in case cancancan trows an notAllowed exception
  def set_not_allowed_url(url)
    @not_allowed_url = url
  end

  # get url to redirect in case cancancan trows an notAllowed exception
  def not_allowed_url
    @not_allowed_url || root_url
  end

  # creates the submit button
  def submit(f)
    render 'shared/save_edit', f: f
  end

  # creates the default cancel button
  def cancel(url)
    render 'shared/cancel', url: url
  end

  # create toasts notifications
  def toasts
    capture do
      flash.each do |key, value|
        unless (value == "Antes de continuar tem de se autenticar ou efectuar um registo.")
          concat(content_tag(:div, value, 'data-toast' => '', class: key))
        end
      end
    end
  end

  def all_routes
    Rails.application.routes.routes.map {|r| [r.defaults[:action], r.defaults[:controller]]}
  end

  def print_errors(f)
    content_tag(:span, '', class: 'has-error') if f.object.errors.any?
  end

  def can_goto?(params = {})
    params.blank? || can?(params.keys.last, params.values.last)
  end

  def cannot_goto?(params = {})
    !can_goto?(params)
  end

  # get the value in the redirect_url params
  # this wil be user when we need to get params[:redirect_url]
  def redirect_url
    params[:redirect_url].blank? ? nil : params[:redirect_url]
  end

  # this wil be user when we need to set a difeent location for rediect
  def redirect_url=(url)
    params[:redirect_url] = url
  end

  # to create
  def set_redirect_input(url = nil)
    hidden_field_tag :redirect_url, url || params[:redirect_url]
  end

  # overrides will_paginate and calls it only if params[:cannot_paginate].blank?
  def next_will_paginate(colletions = nil, options = {})
    if params[:cannot_paginate].blank? || params.delete(:format).eqls?('pdf', 'xls', 'xlsx', 'xml')
      content_tag(:div, class: 'fixed-paginate-botton') do
        will_paginate(colletions, options)
      end
    end
  end

  def default_assessment_reports_url
    year = Assessment.active.last&.year || Time.now.year
    assessment_reports_url(year: year)
  end

  # true if request was made via intenet explorer
  def is_internet_explorer?
    user_agent = request.env['HTTP_USER_AGENT'].to_s.downcase
    # Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)
    user_agent.includes?('msie', 'rv:') && user_agent.includes?('windows nt') && user_agent.includes?('trident') && user_agent.includes?('mozilla')
    # TODO REmove to validate brwoser compatibility
    # To Remove msie
    false
  end

  # stores an array of colors
  def colors_array
    [[33, 150, 243],
     [250, 176, 51],
     [0, 128, 0],
     [24, 255, 2],
     [208, 24, 30],
     [236, 64, 122],
     [171, 71, 188],
     [94, 53, 177],
     [57, 73, 171],
     [30, 136, 229],
     [3, 155, 229],
     [0, 172, 193],
     [0, 255, 0],
     [0, 128, 0],
     [0, 255, 255],
     [0, 128, 128]] + (1..1000).map {|c| [rand(255), rand(255), rand(255)]}
  end

  # get a color from the color array above
  def get_color_at(pos = 0, transparency = 1)
    pos = 0 if colors_array.size <= pos
    color = colors_array[pos]
    "rgba(#{color.first},#{color.second},#{color.third},#{transparency})"
  end

  # get a color from the color array above
  def get_x_colors(x = 0, from = 0, transparency = 1)
    colors_array.slice(from, x).map do |color|
      "rgba(#{color.first},#{color.second},#{color.third},#{transparency})"
    end
  end

  def my_messages_url
    e = current.employee&.id
    if e.present?
      employee_employee_messages_url(e)
    end
  end


  def to_kwanza(number)
    number_to_currency(number, unit: 'AKZ', separator: ',', delimiter: '.', format: '%n %u')
  end

  def to_percentage(number)
    number_to_percentage(number, precision: 2, format: '%n  %')
  end

  def route_t(controller, key, options = {})
    options[:default] ||= [:"routes.defaults.#{key}", key.humanize.capitalize]
    I18n.t("routes.#{controller}.#{key}", options)
  end

  def view_t(key, options = {})
    if options[:default].nil? && key.to_s[0] == '.'
      keys = scope_key_by_partial(key).split('.')
      default = [keys.first, 'defaults', keys.last].join('.').to_sym
      controllers_default = ['controllers_defaults', keys.last].join('.').to_sym
      last_default = keys.last.to_s.humanize.split.map(&:capitalize).join(' ')
      options[:default] ||= [default, controllers_default, keys.last.to_sym, last_default]
    end
    t(key, options)
  end


  # load_from(url, id: 'dsfsdf')
  # loads html on background and place it inside the div
  def load_from(url, options = {})
    options['data-load-from'] = url
    content_tag(:div, '', options)
  end

  # default for the items on the shows view
  def show_item(name, value = nil, options = {})
    content_tag(:p, style: "margin: 0 2px;") do
      content_tag(:strong, view_t(name)) +
      "#{value.present? ? ": #{value}" : nil}".to_s.html_safe
    end
  end

  # default for the items on the shows view
  def blog_show_item(name, value = nil, options = {})
    content_tag(:div, class: "flex-row flex-top blog-show") do
      content_tag(:div, class: "flex-col-xs-3 data-label") do
        content_tag(:span, "#{view_t(name)} :", class: '')
      end +
      content_tag(:div, "#{value.present? ? value : nil}".to_s.html_safe, class: "data-value flex-col-xs-9")
    end
  end

  # next_editable(salary, :base_value, )
  def next_editable(model, column_name, options = {})
    default_types = {integer: :number, string: :text, decimal: :number, float: :number, text: :textarea}

    options[:type] ||= default_types[model.class.columns_hash[column_name.to_s].type] || :text
    options[:title] ||= model.simple_form_label_t(column_name)

    title = options.delete(:label) || options[:title]
    dont_edit_if = options.delete(:dont_edit_if)
    dont_edit_data = options.delete(:dont_edit_data)

    tiltle_html = content_tag(:div) do
      content_tag(:span, style: "color: #474747; font-size: 12px; font-weight: bolder;") do
        title.html_safe
      end
    end

    display_data = dont_edit_data.present? ? dont_edit_data : model.send(column_name)

    editable_html = editable(model, column_name, options)

    if title.present?
      content_tag(:div, style: 'padding: 5px 0;') do
        unless dont_edit_if
          tiltle_html.html_safe +
          editable_html.html_safe
        else
          tiltle_html.to_s.html_safe +
          display_data.to_s.html_safe
        end
      end
    else
      unless dont_edit_if
        editable_html.html_safe
      else
        display_data.to_s.html_safe
      end
    end
  end

  # next_editable(salary, :base_value, )
  def n_editable(model, column_name, options = {})
    default_types = {integer: :number, string: :text, decimal: :number, float: :number, text: :textarea}

    options[:type] ||= default_types[model.class.columns_hash[column_name.to_s].type] || :text
    options[:title] ||= model.simple_form_label_t(column_name)

    title = options.delete(:label) || options[:title]
    dont_edit_if = options.delete(:dont_edit_if)
    dont_edit_data = options.delete(:dont_edit_data)

    tiltle_html = content_tag(:div) do
      content_tag(:span, style: "color: #474747; font-size: 12px; font-weight: bolder;") do
        title.html_safe
      end
    end

    display_data = dont_edit_data.present? ? dont_edit_data : model.send(column_name)

    editable_html = editable(model, column_name, options)

    if title.present?
      content_tag(:div, style: 'display: contents; padding: 5px 0;') do
        unless dont_edit_if
          editable_html.html_safe
        else
          display_data.to_s.html_safe
        end
      end
    else
      unless dont_edit_if
        editable_html.html_safe
      else
        display_data.to_s.html_safe
      end
    end
  end

  # gets a collection of skill and draws a radar for employee_assessment_details
  def skills_radar_data(employee_skills)
    self_assessment = employee_skills.map {|g| [[g.goal.name.truncate(10), "self_assessment".ts], g.self_assessment]}.to_h
    supervisor_assessment = employee_skills.map {|g| [[g.goal.name.truncate(10), "supervisor_assessment".ts], g.supervisor_assessment]}.to_h
    final_assessment = employee_skills.map {|g| [[g.goal.name.truncate(10), "final_assessment".ts], g.final_assessment]}.to_h

    all_assessment = final_assessment.merge(supervisor_assessment).merge(self_assessment)
    RadarChartDataLine.new(all_assessment.to_h).get_data
  end

  # current_url(extras = {})
  # return the current url
  # current_url(limit: 16, id: 5)
  # return the current url and appends params to it
  def current_url(extras = {})
    #uri = URI::parse(request.original_fullpath)
    base, parametros = request.original_fullpath.to_s.split('?')
    if extras.delete(:remove_params).eql?(true)
      base_params = extras.parse_params
    else
      base_params = parametros.to_s.parse_query.merge(extras).parse_params
    end
    base << "?#{base_params}" if base_params.present?
    base
  end

  def action?(*action_names)
    [action_names].flatten.compact.uniq.map(&:to_s).include?(params[:action].to_s)
  end

  def controller?(*controller_names)
    [controller_names].flatten.compact.uniq.map(&:to_s).include?(params[:controller].to_s)
  end

  def context_menu(content, options = {})
    @contex_menu_id ||= 0
    @contex_menu_id = @contex_menu_id + 1
    menu_options = options.delete(:menu_options) || {}
    content_tag(:span, content, options) +
    content_tag(:menu, menu_options) do
      yield
    end
  end

  def context_menu_item(content, options = {})
    options[:label] ||= content
    if block_given?
      content_tag(:menu, options) do
        yield
      end
    else
      tag(:command, options)
    end
  end

  def display_attachments(attachments)
    return if attachments.blank?
    capture do
      attachments.each do |attachement|
        concat(link_to(attachement.url(), style: "padding-left: 5px;", target: :_blank) do
          if attachement.url().to_s.split(".").last.upcase == 'PDF'
            concat(content_tag(:i, '', class: 'fa fa-file-pdf-o pdf-file-regulamento')).html_safe
          else
            concat(content_tag(:i, '', class: 'fa fa-file-photo-o img-file-regulamento')).html_safe
          end
        end).html_safe
      end
    end
  end

  def calc_percentage(total, part)
    if total.present? && part.present? && total > 0
      (part.to_f/total) * 100
    else
      0
    end
  end

  def chart_export_btn(chart_id, download_text = 'Gráfico')
    link_to "#", download: download_text, 'data-save-chart' => chart_id, 'data-tooltip' => "Exportar", 'data-position' => 'left', class: 'export-chart-button', target: :_blank do
      content_tag(:span, '', class: 'fa fa-download', style: 'font-size: 1.5em;')
    end
  end

  def is_action?(action, controller = nil)
    result = params[:action].eqls?(action.to_s, action.to_sym) && controller.eqls?(nil, params[:controller].to_s.gsub('nextsgad/', ''), params[:controller].to_s.gsub('nextsgad/', '').to_sym)
    if block_given?
      concat(yield) if result
    else
      result
    end
  end

  def is_controller?(controller, action = nil)
    result = params[:action].eql?(action.to_s) && controller.to_s.eqls?(nil, params[:controller].to_s.gsub('nextsgad/', ''))
    if block_given?
      concat(yield) if result
    else
      result
    end
  end

  def is_not_action?(action, controller = nil)
    !is_action?(action, controller)
  end

  def is_not_controller?(controller, action = nil)
    !is_controller?(controller, action)
  end

  def micon(name, options = {})
    options[:class] ||= ''
    options[:class] = "mi mi-#{name} #{options[:class]}"
    content_tag(:i, '', options)
  end

  def mticon(name, options = {})
    options[:class] ||= ''
    options[:class] = "material-icons #{options[:class]}"
    content_tag(:i, name, options)
  end

  def cat_menu(options = {})
    content_tag(:div, options) do
      content_tag(:ul) do
        yield
      end
    end
  end

  def cat_item(text, options = {})
    icon = options.delete(:icon)
    href = options.delete(:href) || '#'
    li_options = {}
    if options.delete(:disabled_unless).eqls?(false)
      href = '#'
      li_options[:class] = 'disabled'
    end
    content_tag(:li, li_options) do
      link_to(href, options) do
        content_tag(:div, class: 'cat-icon') do
          micon(icon) if icon.present?
        end +
        content_tag(:div, text, class: 'cat-text')
      end +
      (if block_given?
        content_tag(:ul) do
          yield
        end
      end)
    end
  end

  def cat_btn(direction, content, options = {})
    @cat_id ||= 0
    @cat_id = @cat_id + 1
    options["data-#{direction}cat"] ||= "cat-id-#{@cat_id}"
    options[:class] = options[:class].to_s.split(' ').append('cat-trigger').join(' ')
    content_tag(:div, content.to_s.html_safe, options) + cat_menu(id: options["data-#{direction}cat"]){yield if block_given?}
  end

  def ms_ctx_container(options = {})
    options[:class] = options[:class].to_s.split(' ').append('ms-ContextualMenuExample').join(' ')
    content_tag(:div, options) do
      yield if block_given?
    end
  end

  def ms_ctx_btn(icon, text, options = {})
    options[:class] = options[:class].to_s.split(' ').push('ms-Button ms-CommandBarItem-link').join(' ')
    button_tag(options) do
      (content_tag(:i, '', role: 'presentation', 'aria-hidden': true, class: "ms-ContextualMenu-icon bowtie-icon bowtie-transfer-#{icon}")) +
      content_tag(:span, text, class: 'ms-ContextualMenu-itemText')
    end
  end

  def ms_ctx_menu(options = {})
    content_tag(:ul, class: 'ms-ContextualMenu is-hidden') do
      yield
    end
  end

  def ms_ctx_item(icon, text, href, options = {})
    href ||= 'javascript:;'
    href = 'javascript:;' if block_given?
    li_options = {class: 'ms-ContextualMenu-item'}
    options[:class] = options[:class].to_s.split(' ').push('ms-ContextualMenu-link').join(' ')
    options[:tabindex] = 1
    if options.delete(:disabled_unless).eqls?(false)
      href = 'javascript:;'
      options[:class] = options[:class].to_s.split(' ').push('is-disabled').join(' ')
    end
    li_options[:class] = li_options[:class].to_s.split(' ').push('ms-ContextualMenu-item--hasMenu').join(' ') if block_given?
    content_tag(:li, li_options) do
      link_to(href, options) do
        content_tag(:div, class: 'ms-ContextualMenu-linkContent') do
          (content_tag(:i, '', role: 'presentation', 'aria-hidden': true, class: "ms-ContextualMenu-icon bowtie-icon bowtie-transfer-#{icon}")) +
          content_tag(:span, text, class: 'ms-ContextualMenu-itemText')
        end
      end +
      (if block_given?
        content_tag(:i, '', class: 'ms-ContextualMenu-subMenuIcon ms-Icon ms-Icon--ChevronRight') +
        content_tag(:ul, class: 'ms-ContextualMenu is-hidden') do
          yield
        end
      end)
    end
  end

  COMMON_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def days_in_month(month, year = Time.now.year)
   return 29 if month == 2 && Date.gregorian_leap?(year)
   COMMON_DAYS_IN_MONTH[month]
  end

  def context_menu_panel(link_title, panel_title)
    div(class: "ms-PanelExample") do
      content_tag(:a, link_title, class: "ms-ContextualMenu-link activate-panel") +
      div(class: "ms-Panel") do
        content_tag(:button, class: "ms-Panel-closeButton ms-PanelAction-close") do
          content_tag(:i, '', class: "ms-Panel-closeIcon ms-Icon ms-Icon--Cancel")
        end +
        div(class: "ms-Panel-contentInner") do
          content_tag(:p, panel_title, class: "ms-Panel-headerText") +
          div(class: "ms-Panel-content", style: "padding-bottom: 20px;") do
            if block_given?
              # employee = Employee.map_for_filter
              # employee = employee.pop(employee.size - 1)
              # content_tag(:div, class: "") do
                # select_tag(
                  # 'employee[]',
                  # options_for_select(employee),
                  # class: "default-selectize",
                  # prompt: "Escolha o colaborador",
                  # label: false
                # )
              # end +
              yield.html_safe
            end
          end
        end
      end
    end
  end

  def jpanel_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    link, params = url.split('?')
    params = params.to_s.split('&').push('layout_type=no_layout', 'format=html').join('&')
    url = link + '?' + params
    html_options['href'] ||= url
    html_options['data-remote'] = true
    html_options['class'] = html_options['class'].to_s.split(' ').append(:jpanel).join(' ')
    content_tag(:a, name || url, html_options, &block)
  end

  def jmodal_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    link, params = url.split('?')
    params = params.to_s.split('&').push('layout_type=no_layout', 'format=html').join('&')
    url = link + '?' + params
    html_options['href'] ||= url
    html_options['data-remote'] = true
    html_options['class'] = html_options['class'].to_s.split(' ').append(:jmodal).join(' ')

    content_tag(:a, name || url, html_options, &block)
  end

end
