class AccessGenerateForAllUsers < ActiveRecord::Migration[5.1]
  def change
    User.all.each(&:save)
  end
end
