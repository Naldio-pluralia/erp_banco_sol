class AddIsAnonymousToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :is_anonymous, :boolean, default: false, null: false
  end
end
