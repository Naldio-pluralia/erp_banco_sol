module TableHelper


  def l_table(options = {})
    options[:class] = "#{options[:class]} bordered"
    options[:class] << " next-stupid-sort" unless options.delete(:sortable).eql?(false)
    options[:style] = "#{options[:style]}width: 100%;"
    content_tag(:table, options) do
      yield if block_given?
    end
  end

  def t_header(options = {})
    row_options = options.delete(:row_options)
    row_options = {} unless row_options.class.name.eql?('Hash')
    row_options[:style] = "#{row_options[:style]}"
    row_options[:class] = "tr-scroll-next #{row_options[:class]}"

    options[:style] = "#{options[:style]}"
    options[:class] = "thead-scroll-next #{row_options[:class]}"
    content_tag(:thead, options) do
      content_tag(:tr, row_options) do
        yield if block_given?
      end
    end
  end

  def h_cell(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    data_type = options.delete(:data_type)
    sortable = ""
    unless data_type == false
      options['data-sort'] = data_type || 'string-ins'
      options['data-sort'] = 'int' if options['data-sort'].eqls?('date', :date)
    end
    options.except!(:if, :unless, :roles)

    if options[:align].present?
      align = "#{options.delete(:align)}-align"
    else
      align = 'left-align'
    end

    sortable = "sortable" unless options.delete(:sortable).eqls?(false, :false)
    options[:class] = "#{options[:class]} #{align}  #{sortable}"

    content_tag(:th, options) do
      options.delete(:text).to_s.html_safe + content_tag(:i, '', class: 'fa mc-fa').html_safe
    end
  end

  def t_body(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    options.except!(:if, :unless)

    elements = options.delete(:elements) || []


    check_params = options.delete(:check_params)
    if check_params.present? && params.slice(*[check_params].flatten.uniq).keys.map {|k| k if k.present?}.empty?
      b_row() do
        b_cell(class: 'text-center') do
          content_tag :h4, options.delete(:params_empty_message)
        end
      end
    else
      content_tag(:tbody, class: "tbody-scroll-next #{options.delete(:class)}") do
        elements.each do |element|
          yield(element) if block_given?
        end
      end
    end
  end

  def b_row(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    options.except!(:if, :unless)
    options ||= {}

    options['data-href'] = options.delete(:link_to) if options[:link_to].present?
    options.delete('data-href') if options[:link_to_if] == (false)

    content_tag(:tr, options) do
      yield if block_given?
    end
  end

  def b_cell(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    element = options.delete(:element)
    data_order = options.delete(:data) || element
    options['data-sort-value'] = data_order if data_order.present?
    if options[:align].present?
      align = "#{options.delete(:align)}-align"
    elsif data_order.class.name.eqls?(Integer.name, Float.name, BigDecimal.name)
      align = 'right-align'
    else
      align = 'left-align'
    end

    options[:style] ||= ""
    options[:class] ||= ""
    options[:class] << " #{align} " if align.present?



    options.except!(:if, :unless)
    content_tag(:td, options) do
      if block_given?
        yield
      else
        element.to_s.html_safe
      end
    end
  end


end
