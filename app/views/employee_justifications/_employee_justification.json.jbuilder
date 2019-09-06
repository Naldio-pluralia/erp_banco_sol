json.extract! employee_justification, :id, :employee_id, :attachments, :employee_note, :supervisor_note, :created_at, :updated_at
json.url employee_justification_url(employee_justification, format: :json)
