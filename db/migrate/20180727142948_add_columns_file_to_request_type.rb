class AddColumnsFileToRequestType < ActiveRecord::Migration[5.1]
  def change
    add_column :request_types, :virtual_object_attachments, :json, default: {}
  end
end
