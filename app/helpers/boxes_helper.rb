module BoxesHelper
  @nextbss_box_id = 0

  def next_nextbss_box_id
    @nextbss_box_id ||= 0
    @nextbss_box_id += 1
    "nextbss_box_id_#{@nextbss_box_id}"
  end
  
  # Creates a box
  def box(options = {}, &block)
    size = options.delete(:size)
    options = {class: 'box effect6', style: "min-height: #{size || '300px'};"}.merge(options)
    content_tag(:div, options) do 
      block.call if block_given?
    end
  end

  def box_header(title = nil, options = {}, &block)
    content_tag(:div, class: 'box-header') do 
      content_tag(:div, class: 'box-title truncate', style: "") do 
        content_tag(:span, title.to_s.html_safe, options)
      end +
      content_tag(:div, class: 'box-actions') do 
        block.call if block_given?
      end
    end
  end

  # creates an action for a box
  def box_action(icon, options = {})
    return unless can_goto?(options.delete(:if_can))
    filter = options.delete(:filter)
    export = options.delete(:export)
    table_export = options.delete(:table_export)
    modal_trigger = options.delete(:modal_trigger)
    tooltip = options.delete(:tooltip)
    if tooltip.present?
      options['data-position'] = "bottom"
      options["data-tooltip"] = tooltip
    end

    options[:class] = "box-action #{options[:class]}"

    if filter.present?
      options[:href] ||= "#filter-#{filter}-modal"
      modal_trigger = true
    end

    if export.present?
      uri = Addressable::URI.new
      uri.query_values = params.permit!.except(:controller, :action)
      options[:href] = "#{request.original_url.split('?')[0]}.#{export}?#{uri.query}"
      options[:target] = '_blank'
    end

    if table_export.present?
      options['data-export-table'] = table_export
      options['data-export-format'] = options.delete(:export_format) || :excel
    end

    remote = options.delete(:remote)
    if remote.present?
      options['data-remote'] = true
    end

    options['data-method'] = options.delete(:method)

    options[:class] << (modal_trigger ? ' modal-trigger' : '')
    options[:style] = ""
    if block_given?
      content_tag(:a, options) do
        fa_icon(icon) + yield
      end
    else
      content_tag(:a, fa_icon(icon), options)
    end
  end

  def box_action_dropdown(icon, options = {})
    return unless can_goto?(options.delete(:if_can))
    id = options[:data_activates] || next_nextbss_box_id
    content_tag(:a, fa_icon(icon), class: "next-dropdown-button box-action #{options[:class]}", target: options[:target], "data-activates": id, "data-beloworigin": "true", 'data-constrain-width': false) +
        content_tag(:ul, id: id, class: "nextbss-dropdown dropdown-content") do
          yield if block_given?
        end
  end

  def box_dropdown_item(options = {})
    return unless can_goto?(options.delete(:if_can))
    content = options.delete(:item)
    filter = options.delete(:filter)
    export = options.delete(:export)
    modal_trigger = options.delete(:modal_trigger)

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

    options[:style] = options[:style]

    content_tag(:li) do
      content_tag(:a, content.to_s.html_safe, options)
    end


  end

  #creates an redirect_url and cancel url inputs on th form
  def form_url_helpers(form)
    form.input(:redirect_url, as: :hidden) +
    form.input(:cancel_url, as: :hidden) +
    form.input(:render_view, as: :hidden)
  end
end
