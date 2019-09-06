class PdfApplication < Prawn::Document
  include Prawn::View
  include ApplicationHelper
  include PrawnHelper
  include ActionView::Helpers::NumberHelper


  def draw
    page_count.times do |i|
      go_to_page(i+1)
      # Logos
      prawn_header(Setting.last)
      # Page Numbers
      bounding_box([515, bounds.bottom + 14], :width => bounds.width, :height => 30) {
        text I18n.t('x_of_y', x: i + 1, y: page_count), size: 9, :valign => :bottom}
    end
  end

  def pdf_t(key, options = {})
    I18n.t(key, options)
  end
end