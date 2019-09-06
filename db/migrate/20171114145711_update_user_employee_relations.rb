class UpdateUserEmployeeRelations < ActiveRecord::Migration[5.1]
  def change
    User.all.each do |u|
      u.save(validate: false)
    end
  end
end
