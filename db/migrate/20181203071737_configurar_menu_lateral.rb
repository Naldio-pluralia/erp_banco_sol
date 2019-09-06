class ConfigurarMenuLateral < ActiveRecord::Migration[5.1]
  def change
    Plugin.generate_side_menu true
  end
end
