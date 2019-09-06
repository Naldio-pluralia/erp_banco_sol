class RenameColumnFromQuestion < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :type, :kind
  end
end

