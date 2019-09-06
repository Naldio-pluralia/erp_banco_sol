module MenuHelper

  def sn_container(options = {})
    options[:class] = "#{options[:class]} side-nav fixed"
    options[:id] ||= 'nav-mobile'
    content_tag(:ul, options) do
      concat(sn_header) + concat(sn_body {yield}) + concat(sn_footer)
    end
  end

  def sn_header(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    content_tag(:li, class: 'sn-header') do
      (link_to(send("edit_#{current.user.class.name.downcase}_registration_path")) do
        image_tag(current.user.avatar.url, class: 'responsive-img circle') +
            content_tag(:p, current.user.full_name, class: "avatar-full-name truncate") +
            content_tag(:p, current.user.email || 'n/a'.ts, class: "email-text truncate")
      end).html_safe
    end
  end

  def sn_body(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    content_tag(:li, class: 'sn-body') do
      content_tag(:ul, class: 'mtz collapsible', 'data-collapsible' => 'accordion') do
        yield if block_given?
      end
    end
  end

  def sn_item(texto, icon, options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    begin
      return if cannot_goto?(options.delete(:if_can))
    rescue
      puts $!.backtrace
      return
    end

    options_a = {}
    options_div = {}
    options_a[:class] = ""
    href = options[:href]
    options_a[:method] = options[:method] if options[:method].present?
    options_div[:id] = "#{options[:href].to_s.delete('#')}"
    options_div[:style] = ""
    options_div.delete(:href)
    options_icon = {icon: icon}.merge(options.delete(:icon_options) || {})

    content_tag(:li) do
      concat(content_tag(:a, class: "collapsible-header #{'with-block' if block_given?}", href: href) do
        content_tag(:span, class: 'icon') do
          icon(options_icon)
        end +
            content_tag(:span, class: 'texto truncate') do
              texto.to_s.html_safe
            end
      end)
      concat(content_tag(:div, class: 'collapsible-body') {content_tag(:ul, class: 'collapsible', 'data-collapsible' => 'accordion') {yield}}) if block_given?
    end
  end

  def sn_footer(options = {})
    return if options[:if].eql?(false)
    return if options[:unless].eql?(true)
    content_tag(:li, class: 'sn-footer') do
      content_tag(:div, class: '', style: 'margin:0;') do
        content_tag(:div, class: 'text-center') do
          # content_tag(:div, class: 'sn-configuracoes') do
          #   if current.user.present?
          #     link_to settings_url do
          #       icon(icon: :settings_at_mtl)
          #     end
          #   end
          # end
        end +
            content_tag(:div, class: 'text-center') do
              content_tag(:div, class: 'sn-sair') do
                link_to "SAIR", send("destroy_#{current.user.class.name.downcase}_session_path"), method: :delete, data: {disable_with: "<i class='fa fa-spinner fa-spin' style='color: #000'></i>"}
              end
            end
      end
    end
  end

  def sn_button
    (link_to(application_toogle_menu_path, method: :patch, remote: true, style: 'position: fixed;', class: 'sn_button_link') do
      content_tag(:button, type: :offcanvas, class: 'sn_button') do
        icon(class: 'fa fa-angle-right sn_button_arrow')
      end
    end).html_safe
  end
end
