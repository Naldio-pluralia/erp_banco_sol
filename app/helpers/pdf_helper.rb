module PdfHelper

  include ApplicationHelper

  def table_header_color
    'fab033'
  end

  def text_header_color
    'ffffff'
  end
  # logotipo da entidade
  def entity_logo
    bounding_box([0, cursor + 0], :width => 100, :height => 70) do
      transparent(0.5) { stroke_bounds }
      if Rails.env.development? || Rails.env.test? # Teste para os ambientes
        image configuration.entity_logo.path, :position => :left, :width => 60
      else
        image open(configuration.entity_logo.path), :position => :left, :width => 60
      end
    end
    move_down 10
  end

  def avatar_employee

    bounding_box([440, cursor + 80], :width => 100, :height => 70) do
      transparent(0.5) { stroke_bounds }
      # image @employee.avatar.url, :position => :right, :width => 60
    end
    move_down 10
  end









end
