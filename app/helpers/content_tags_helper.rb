module ContentTagsHelper
  PERSONA_COLORS = [:red, :blue, :green, :orange]
  # mdl_card draws a simple material design lite card
  def mdl_card(options = {}, &block)
    options[:style] = "width: 100%; padding: 8px; height: auto;#{options[:style]}"
    options[:class] = "#{options[:class]} mdl-card mdl-shadow--2dp"
    content_tag(:div, options) do
      block.call if block_given?
    end
  end

  def div(content_or_options_with_block = nil, options = nil, escape = true, &block)
    content_tag(:div, content_or_options_with_block, options, escape, &block)
  end

  def divc(content_or_options_with_block = nil, options = nil, escape = true, &block)
    concat(div(content_or_options_with_block, options, escape, &block))
  end


  # Creates a modal triggerer
  def modal_btn(name = nil, options = nil, html_options = nil, &block)
    if block_given?
      html_options, id = options, name
    else
      id = options
    end
    html_options ||= {}
    html_options[:class] = "#{html_options[:class]} waves-effect waves-light btn btn-flat btn-cancel-form"
    html_options[:style] = "#{html_options[:style]} background-color: #fab033; color: #fff"
    html_options[:href] = id

    content_tag("a".freeze, name || id, html_options, &block)
  end

  # creates a modal
  def mtz_modal(id, options = {}, &block)
    options[:class] = "#{options[:class]} modal"
    options[:id] = id
    content_tag(:div, options) do
      content_tag(:div, class: 'modal-content') do
        block.call if block_given?
      end
    end
  end

  # Creates a span wich will recieve an element from a slider connected to an input
  def slider_span(ref, options = {})
    options['data-set-from-slider'] = ref
    content_tag(:span, '', options)
  end

  # creates a slider for an ipnut
  # multi_slider_for('#goal_goal_type')
  def slider_for(ref, options = {})
    options['data-slider-for'] = ref
    content_tag(:div, '', options)
  end

  # Creates a slider for several inputs, where the params are the inputs ids
  # multi_slider_for('#goal_goal_type,#goal_name')
  def multi_slider_for(*refs)
    options = {}
    options['data-sliders-for'] = [refs].flatten.join(',').split(',').flatten.uniq.join(',')
    content_tag(:div, '', options)
  end

  # Create a modal and form for filtering data
  # filter_modal(url, id, options = {}, &block)
  # url -> url where the filter will go
  # id -> id string to use to create the modal and form id
  def filter_modal(url, id, options = {}, &block)
    options[:class] = "modal bottom-sheet filter-modal#{options[:class]}"
    options[:id] = "filter-#{id}-modal"
    options['data-reactivate-modal'] = true if "##{options[:id]}" == params['modal_open']
    content_tag(:div, options) do
      content_tag(:div, class: 'modal-content') do
        form_tag url, :method => 'get', class: "auto_submit_form", id: "filter-#{id}-form" do
          hidden_field_tag(:modal_open, options[:id])
          block.call
        end
      end +
          content_tag(:div, class: 'modal-footer') do
            action_btn(content: t(:clear), href: url, color: :white) +
                action_btn(content: t(:close), color: :gray, class: 'modal-action modal-close waves-effect waves-light')
          end +
          tag(:br) +
          tag(:br) +
          tag(:br) +
          tag(:br) +
          tag(:br) +
          tag(:br)
    end
  end

  def employee_persona(e)
    div(class: 'ms-Persona ms-Persona--sm', style: 'padding-bottom: 11px;') do
      divc(class: 'ms-Persona-imageArea', style: 'padding-bottom: 11px;') do
        if e.user&.avatar.present?
          image_tag(e.user.avatar_url, class: 'ms-Persona-image')
        else
          div(e.persona_initials, class: "ms-Persona-initials ms-Persona-initials--#{PERSONA_COLORS[rand(PERSONA_COLORS.size)]}")
        end
      end
      divc(class: "ms-Persona-details") do
        divc(e.name, class: "ms-Persona-primaryText")
        divc(e.efective_position&.new_name_and_number || 'N/D', class: "ms-Persona-secondaryText")
      end
    end
  end

  # Exemplo
  # <%=
  #   tabulator_tag(id: 'employees', tabulate: {
  #     height: "500px",
  #     layout: :fitColumns,
  #     ajaxURL: employees_url('employee_id[]': params[:employee_id], 'department_id[]': params[:department_id], 'function_id[]': params[:function_id], 'position_id[]': params[:position_id], 'paygrade[]': params[:paygrade], 'level[]': params[:level], format: :json),
  #     ajaxProgressiveLoad:"scroll",
  #     paginationSize: 20,
  #     placeholder:"Sem Dados",
  #     columns: [
  #       {title: "employee_name".ts, field: :first_and_last_name},
  #       {title: "employee_number".ts, field: :number},
  #       {title: "employee_paygrade_level".ts, field: :paygrade},
  #       {title: "employee_paygrade".ts, field: :level}
  #     ]
  #   })
  # %>
  def tabulator_tag(options = {}, &block)
    options[:tabulator] = (options[:tabulator] || {}).to_json
    content_tag(:div, '', options)
  end
end
