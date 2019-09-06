json.extract! request_type, :id, :name, :note, :requires_supervisor_approval, :requires_supervisor_supervisor_approval, :requires_dpe_approval, :requires_dpe_supervisor_approval, :created_at, :updated_at
json.url request_type_url(request_type, format: :json)
