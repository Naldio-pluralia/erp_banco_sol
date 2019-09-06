module TabsHelper

  def tab(options = {})
    content_tag(:div, class: 'row tab-container') do
      yield if block_given?
    end
  end

  def tab_header(options = {})
    content_tag(:div, class: 'col s12') do
      content_tag(:ul, class: 'tabs') do
        yield if block_given?
      end
    end
  end

  def tab_header_item(id, text, options = {})
    options[:class] = [options.delete(:class).to_s.split(' ')].flatten.uniq
    options[:class] << 'active' if params[:active_tab].to_s == id.to_s
    content_tag(:li, class: 'tab') do
      content_tag(:a, href: "##{id}", class: options[:class].uniq.join(' ')) do
        text.to_s.html_safe
      end
    end
  end

  def tab_body(id, options = {})
    content_tag(:div, id: id, class: 'col s12 tab-body') do
      yield if block_given?
    end
  end
end
