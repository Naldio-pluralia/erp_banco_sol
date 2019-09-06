class AddLogoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :configurations, :logo, :string if table_exists? :configurations
    remove_column :configurations, :entity_logo if table_exists? :configurations
  end
end
