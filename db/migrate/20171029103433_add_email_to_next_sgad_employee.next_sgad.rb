# This migration comes from next_sgad (originally 20171029103212)
class AddEmailToNextSgadEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :email, :string
  end
end
