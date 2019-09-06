module ToolbarHelper

  def change_status_of_result_label(result)
    if result.result_invalid?
      'result-text-decoration'
    else
      ''
    end
  end

  def change_status_of_result_input(result)
    if result.result_invalid?
      'checked'
    else
      ''
    end
  end

  def assessment_color(employee, assessment, evaluation)
    goals = employee.employee_goals.where(assessment_id: assessment&.id)

    if goals.where("#{evaluation}_assessment": 0).count == goals.count
      return "#d50000" # Red
    elsif goals.where("#{evaluation}_assessment": 0).exists?
      return "#fab033" # Yellow
    else
      return "#00c853" # Green
    end
  end

  def employee_self_assessment_color(employee_assessment, type)
    color = if employee_assessment.send("#{type}_pending?")
              '#d50000'
            elsif employee_assessment.send("#{type}_in_progress?")
              '#fab033'
            elsif employee_assessment.send("#{type}_completed?")
              '#00c853'
            else
              '#eee'
            end

    icon(mtl: :lens, style: "color: #{color}; font-size: 15px;")
  end

  def employee_assessment_color(value)
    # 1 pending
    # 2 completed
    # 3 in_progress
    color = if value == 1
              '#d50000'
            elsif value == 3
              '#fab033'
            elsif value == 2
              '#00c853'
            else
              '#eee'
            end

    icon(mtl: :lens, style: "color: #{color}; font-size: 15px;")
  end

  #TODO - Remover esse metodo

  def button_close_modal(params={})
    link_to "back".ts, params[:back_to], class: "waves-effect waves-light btn btn-flat btn-cancel-form"
  end

  def close_modal_result(params={})
    link_to "back".ts, params[:back_to], class: "waves-effect waves-light btn btn-flat btn-cancel-form"
  end

  def button_print(params = {})
    link_to params[:url], :target => "_blank", class: "waves-effect waves-light btn btn-flat btn-cancel-form", style: "background-color: #2196f3; color: #fff; margin-top: -23px; padding: 0px!important;" do
      params[:icon].html_safe
    end
  end

  def close_modal_btn
    content_tag(:a, "back".ts, href: "#", class: "waves-effect waves-light btn btn-flat btn-cancel-form modal-action modal-close")
  end

  def buttons_modal(params = {})
    return if cannot_goto?(params.delete(:if_can))
    text = params[:text]
    url = params[:url]
    link_to("#{text}", url, class: "#{params[:class_css]} btn modal-trigger btn-adicinar-objectivo btn-color")
  end

  def buttons(params = {})
    text = params[:text]
    url = params[:url]
    link_to("#{text}", url, class: "mdl-button", style: "background-color: #fab033; color: #fff")
  end

  def breadcrumb_index(itens_menu)
    return if itens_menu.blank?
    content_tag(:div, :class => "nav-wrapper", style: "margin-top: 5px;") do
      content_tag(:div, :class => "col s12 no-padding") do
        itens_menu.each do |item, url|
          concat(content_tag(:a, item, href: url, class: "breadcrumb br-cru-color size-readcrumbs").html_safe)
        end
      end
    end
  end

  def toolbar(params = {})
    params[:btn_export] = params[:btn_export].blank? ? {} : params[:btn_export]

    concat(content_tag(:hr).html_safe)
    concat(content_tag(:div, class: "row", style: "padding: 0;") do
      concat(content_tag(:div, class: "col s6", style: "margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;") do
        breadcrumb_index(params[:itens_menu])
      end).html_safe

      concat(content_tag(:div, class: "col s6 right", style: "text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;") do
        params[:bar_arguments].each do |key, url|
          if params[:if_can].blank? || can?(params[:if_can].keys.last, params[:if_can].values.last)
            concat(content_tag(:a, "add".ts, href: url, class: "waves-effect waves-light btn  modal-trigger", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "add_modal"
            concat(content_tag(:a, "edit".ts, href: url, class: "waves-effect waves-light btn  modal-trigger", style: "background-color: #2196f3; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "edit_modal"
            concat(content_tag(:a, "upload_file".ts, href: url, class: "waves-effect waves-light btn  modal-trigger", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "upload_file"
            concat(content_tag(:a, "add".ts, href: url, class: "waves-effect waves-light btn ", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "new"
            concat(content_tag(:a, "edit".ts, href: url, class: "waves-effect waves-light btn ", style: "background-color: #4caf50; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "edit"
            concat(content_tag(:a, "goal.new".ts, href: url, class: "waves-effect waves-light btn ", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "assessment_new_goal"
            concat(content_tag(:a, "Excel", href: url, class: "waves-effect waves-light btn ", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "excel_export_btn"
            concat(content_tag(:button, "PNG", href: url, class: "waves-effect waves-light btn oc-btn-png", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "png_export_btn"
            concat(content_tag(:button, "Filtro", "data-filter": url, class: "filter-active waves-effect waves-light btn btn-flat btn-cancel-form", style: "background-color: #4caf50; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "filter"
            concat(content_tag(:a, "destroy".ts, href: url, class: "waves-effect waves-light btn btn-flat btn-cancel-form", style: "background-color: #da362a; color: #fff; margin-left: 5px;", "data-confirm": "Are you sure?", rel: "nofollow", "data-method": "delete").html_safe) if key.to_s == "delete"

            concat(content_tag(:button, "user.reset_password".ts, href: url, class: "waves-effect waves-light btn btn-flat btn-cancel-form", style: "background-color: #4caf50; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "user_reset_password"
            concat(content_tag(:button, t("justification.singular"), href: url, class: "waves-effect waves-light btn modal-trigger", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "justification_modal"

            # concat(content_tag(:button, "user.user_generate_password".ts, href: url, class: "waves-effect waves-light btn btn-flat btn-cancel-form", style: "background-color: #fab033; color: #fff; margin-left: 5px;").html_safe) if key.to_s == "user_generate_password"

          end
        end
      end).html_safe
    end).html_safe
    concat(content_tag(:hr).html_safe)

  end

  # Toolbars second version
  def index_bar(options = {}, &block)
    return unless can_goto?(options.delete(:if_can))

    content_tag(:hr) +
        content_tag(:div, class: "row", style: "padding: 0;margin-bottom: 0px;") do
          content_tag(:div, class: "col s5", style: "margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;") do
            breadcrumb_index(options[:itens])
          end +
              content_tag(:div, class: "col s7 right", style: "text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;") do
                block.call if block_given?
              end
        end +
        content_tag(:hr)
  end

  def action_btn(options = {})
    return unless can_goto?(options.delete(:if_can))
    content = options.delete(:content)
    filter = options.delete(:filter)
    export = options.delete(:export)
    table_export = options.delete(:table_export)
    modal_trigger = options.delete(:modal_trigger)
    colors = {yellow: '#fab033', blue: '#2196f3', green: '#4caf50', red: '#da362a', gray: '#616161'}
    color = colors[options.delete(:color)] || '#fab033'

    options[:class] = "waves-effect waves-light btn #{options[:class]}"

    if filter.present?
      options[:href] ||= "#filter-#{filter}-modal"
      content ||= t('filter')
      modal_trigger = true
      color = colors[:blue]
    end

    if export.present?
      uri = Addressable::URI.new
      uri.query_values = params.permit!.except(:controller, :action)
      content ||= t(export)
      color = colors[:yellow]
      options[:href] = "#{request.original_url.split('?')[0]}.#{export}?#{uri.query}"
      options[:target] = '_blank'
    end

    if table_export.present?
      color = colors[:yellow]
      options['data-export-table'] = table_export
      options['data-export-format'] = options.delete(:export_format) || :excel
      content ||= t(options['data-export-format'])
    end

    remote = options.delete(:remote)
    if remote.present?
      options['data-remote'] = true
    end

    options['data-method'] = options.delete(:method)

    options[:class] << (modal_trigger ? ' modal-trigger' : '')
    options[:style] = "background-color: #{color}; color: #fff; margin-left: 5px; #{options[:style]}"
    if block_given?
      content_tag(:a, options) do
        yield
      end
    else
      content_tag(:a, content.to_s.html_safe, options)
    end
  end

  def action_btn_dropdown(options = {})
    return unless can_goto?(options.delete(:if_can))
    content = options.delete(:content)
    id = options[:data_activates] || next_auto_id
    content_tag(:a, content.to_s.html_safe, class: "next-dropdown-button btn #{options[:class]}", target: options[:target], "data-activates" => id, "data-constrain-width" => false, "data-beloworigin" => "true") +
        content_tag(:ul, id: id, class: "nextbss-dropdown dropdown-content") do
          yield if block_given?
        end
  end

  def dropdown_item(options = {})
    return unless can_goto?(options.delete(:if_can))
    content = options.delete(:item)
    filter = options.delete(:filter)
    export = options.delete(:export)
    modal_trigger = options.delete(:modal_trigger)

    colors = {yellow: '#fab033', blue: '#2196f3', green: '#4caf50', red: '#da362a', gray: '#616161'}
    color = colors[options.delete(:color)] || '#fab033'

    options[:class] = "#{options[:class]}"

    if filter.present?
      options[:href] ||= "#filter-#{filter}-modal"
      content ||= t('filter')
      modal_trigger = true
      color = colors[:blue]
    end

    if export.present?
      uri = Addressable::URI.new
      uri.query_values = params.permit!.except(:controller, :action)
      content ||= t(export)
      # color = colors[:blue]
      options[:href] = "#{request.original_url.split('?')[0]}.#{export}?#{uri.query}"
      options[:target] = '_blank'
    end

    remote = options.delete(:remote)
    if remote.present?
      options['data-remote'] = true
    end

    options['data-method'] = options.delete(:method)
    options[:class] << (modal_trigger ? ' modal-trigger' : '')

    options[:style] = "background-color: #{color}; color: #fff; #{options[:style]}"

    content_tag(:li) do
      content_tag(:a, content.to_s.html_safe, options)
    end


  end


end
