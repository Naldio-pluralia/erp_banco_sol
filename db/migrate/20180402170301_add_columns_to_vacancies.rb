class AddColumnsToVacancies < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancies, :contract_type, :integer, null: false, default: 0
    add_column :vacancies, :offer_ends_at, :date, null: false, default: '1/1/9999'
    add_column :vacancies, :country, :string, null: false
    add_column :vacancies, :city, :string, null: false
    add_column :vacancies, :province, :string, null: false
    add_column :vacancies, :job_description, :string, null: false
    add_column :vacancies, :year_of_experience, :integer, null: false, default: 0
  end
end
