# This migration comes from next_sgad (originally 20171026060351)
class CopiesPosiitonIdToEmployees < ActiveRecord::Migration[5.1]
  def change
    data = (Position.all).group_by{|f| [f.class.name, f.employee_id]}
    Employee.all.each do |e|
      e.position_id = data[[Position.name, e.id]]&.last&.id
      e.save
    end
  end
end
