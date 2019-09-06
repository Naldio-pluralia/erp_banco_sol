namespace :employee_absences do
  desc "Marca Faltas automaticamente todos os dias as 0H"
  task self_register: :environment do
    EmployeeAbsence.delay.create_todays_system_absences
  end

  # desc "Marca Faltas automaticamente todos os dias as 0H"
  # task :self_register_from, [:day, :month :year] => [:environment] do |t, args|
  #   day = args[:day]
  #   month = args[:month]
  #   year = args[:year]
  #   # data = Time.now(date.split("/").third, date.split("/").second, date.split("/").first).to_date
  #   # EmployeeAbsence.delay.create_todays_system_absences(data)
  # end
end
