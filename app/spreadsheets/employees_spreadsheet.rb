class EmployeesSpreadsheet < Spreadsheet::Workbook
  def initialize(employees, params)
    sheet = create_worksheet name: I18n.t(:employees)
    sheet.row(0).concat [I18n.t('employees')]
    sheet.row(1).concat [I18n.t('employee_name'), I18n.t('employee_number'), I18n.t('employee_paygrade'), I18n.t('employee_paygrade_level')]
    employees.each_with_index do |f, index|
      sheet.row(2 + index).concat [f.first_and_last_name, f.number, f.paygrade, f.level]
    end
  end
end