module PrawnHelper
  def prawn_header(setting = Setting.last)
    bounding_box([0, bounds.height + 109], :width => 540, :height => 72) do
      # stroke_bounds
      logotipo = setting.entity_logo ? setting.entity_logo_url.to_s : "#{Rails.root}/app/assets/images/bancosol-logo.png"

      if Rails.env.development? || Rails.env.test? # Tese para os ambientes
        if (setting.entity_logo.present?)
          image "#{Rails.root}/public#{logotipo}", :position => :left, :width => 130
        else
          image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
        end
      else
        if (setting.entity_logo.present?)
          image "/home/deploy/nextbss/shared/public#{logotipo}", :position => :left, :width => 130
        else
          image "#{Rails.root}/app/assets/images/bancosol-logo.png", :position => :left, :width => 130
        end
      end
    end
  end
end
