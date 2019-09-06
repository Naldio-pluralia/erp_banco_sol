class GenerateSideMenu130420181833 < ActiveRecord::Migration[5.1]
  def up
    Plugin.generate_side_menu true
  end
  def down
    
  end
end
