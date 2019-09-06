class AddVirtualObjectAttachmentsToEmployeeRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_requests, :virtual_object_attachments, :json, default: {}
  end
end
