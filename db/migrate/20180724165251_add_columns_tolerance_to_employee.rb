class AddColumnsToleranceToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :tolerance, :integer, default: 0, null: false
    # Employee.all.each do |e|
    #   e.tolerance = 0
    #   p '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    #   p e
    #   p '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    #   e.save(validate: false)
    # end
  end
end
