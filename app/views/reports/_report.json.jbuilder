json.extract! report, :id, :employee_id, :name, :note, :created_at, :updated_at
json.url report_url(report, format: :json)
