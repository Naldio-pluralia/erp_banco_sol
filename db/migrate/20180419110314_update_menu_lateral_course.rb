class UpdateMenuLateralCourse < ActiveRecord::Migration[5.1]
  def change
    Plugin.generate_side_menu(true)
    p "--"*20, "Menu updated"
  end
end
