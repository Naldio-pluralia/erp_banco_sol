module EmailTagsHelper
  # writes a simple text line on email with translation
  # stands for mail translated text
  def mail_t_text(text, params = {})
    content_tag(:p, t(text, params))
  end

  # writes a simple text line on email with translation
  def mail_text(&block)
    block.call
  end

  def mail_general(params = {})
    content_tag(:div, class: "row") do
      yield if block_given?
    end
  end

  def mail_header
    content_tag(:div, class: "col s12", style: "background-color: black;") do
      concat(content_tag(image_tag("/assets/bancosol-logo.png", height: "65px", alt: "")).html_safe)
      concat(content_tag(:hr).html_safe)
    end
  end

  def mail_body
    #code
  end

  def mail_footer(params = {})
    content_tag(:div, class: "col s12", style: "background-color: black;") do
      concat(content_tag(:hr).html_safe)
    end
    content_tag(:div, class: "col s12") do
      concat(content_tag(:br).html_safe)
      params[:elements].each do |key, element|
        concat(content_tag(:p, "#{element}", style: "margin: 0px; font-size: 15px;").html_safe)
      end
    end
  end



end
