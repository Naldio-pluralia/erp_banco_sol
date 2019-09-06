namespace :time do

  desc "Cria o ano de férias de cada colaboradoror"
  task creates_vacation_year: :environment do
    # a ser chamado no dia 1 de janeiro
    if (Date.current.month == 1 && Date.current.day == 1)
      year = Date.current.year
      valid_from = Date.current
      valid_until = (Date.current + TimeSetting.latest.number_of_months_to_enjoy_vacation.months - 1.month).end_of_month
      data = Employee.all.ids.map{|f| {employee_id: f, number_of_days: 0, year: year, valid_from: valid_from, valid_until: valid_until}}.flatten
      p EmployeeAvaliableVacation.create(data)
    end
  end

  desc "Incrementa os dias de férias disponíveis de cada colaborador"
  task increment_vacation: :environment do
    # Incrementa 11 dias de férias no dias 1 de julho
    # ou no princípio do ano
    if (Date.current.month == 7 && Date.current.day == 1) || (Date.current.month == 1 && Date.current.day == 1)
      p EmployeeAvaliableVacation.where(year: (Date.current - 1.month).year).update_all("number_of_days = number_of_days + 11")
    end
  end
end
