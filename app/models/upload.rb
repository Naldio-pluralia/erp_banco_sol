class Upload < ApplicationRecord
  attr_accessor :data, :type, :functions, :departments, :employees, :positions, :attendances, :users
  mount_uploader :file, SpreadsheetUploader

  validates_presence_of :file
  validates_integrity_of :file
  validates_processing_of :file
  validate :file_format

  def file_format
    errors.add(:file, :file_must_be_xls.ts) if file.present? && !file.url.to_s.split('.').last.eqls?('xls', 'xlsx', 'csv')
  end

  def read_data
    self.data = []

    sheet = Spreadsheet.open(file.path).worksheet(0) if file.url.to_s.split('.').last.eqls?('xls')
    sheet = SimpleXlsxReader.open(file.path).sheets.first.rows if file.url.to_s.split('.').last.eqls?('xlsx')
    #sheet = File.open(file.path).map{|line| line.split(';')} if file.url.to_s.split('.').last.eqls?('csv')
    sheet.each_with_index do |row, index|
      next unless index >= 1 if self.type.eqls?('functions', 'departments', 'employees', 'positions', 'users')
      break if index >= 1900 if self.type.eqls?('functions', 'departments', 'employees', 'positions', 'users')
      r = []
      row.each {|cell| r << cell}
      self.data << r
    end

    all_funtions = Function.where.not(number: [nil, '']).index_by {|f| f.number}
    all_departments = Department.where.not(number: [nil, '']).index_by {|f| f.number}
    all_positions = Position.where.not(number: [nil, '']).index_by {|f| f.number}
    all_employees = Employee.where.not(number: [nil, '']).index_by {|f| f.number}

    case type
      when 'functions'
        # ['name']
        self.functions = data.map {|f| Function.new(name: f.first, number: f.second.to_s) if f[0].present?}.compact || []
      when 'departments'
        # ['name', 'number', 'parent number, obs. not id']
        self.departments = data.map {|f| Department.new(name: f.first,
          number: f.second.to_s.split('.').first,
          department_id: all_departments[f[2].to_s.split('.').first]&.id) if f[0].present?}.compact || []
      when 'employees'
        # {0: 'names', 1: 'number', 2: 'level', 3: 'paygrade', 4: new_position,
        # 5: position_name, 6: position_function_id, 7: position_position_id,
        # 8: position_department_id, 9: new_account, 10: user_email}
        self.employees = []
        data.each do |f|
          if f[0].present?
            nomes = f.first.to_s.split(' ')
            self.employees << Employee.new() do |e|
              e.first_name = nomes.shift
              e.last_name = nomes.pop
              e.middle_name = nomes.join(' ')
              e.number = f[1].to_s.split('.').first
              e.level = f[2].to_s.split('.').first
              e.paygrade = f[3].to_s.split('.').first.to_i
              e.new_position = f[4].to_s.downcase.eqls?('1', 'true', 'sim', 't', 's')
              if e.new_position
                e.position_name = f[5]
                e.position_function_id = all_funtions[f[6].to_s.split('.').first]&.id
                e.position_position_id = all_positions[f[7].to_s.split('.').first]&.id
                e.position_department_id = all_departments[f[5].to_s.split('.').first]&.id
              end
              e.new_account = f[9].to_s.downcase.eqls?('1', 'true', 'sim', 't', 's')
              if e.new_account
                e.user_email = f[10].to_s.gsub('mailto:', '')
              end
            end
          end
        end
        self.employees = employees.compact
      when 'positions'
        self.positions = data.map {|f| Position.new(name: f.first, number: f.second.to_s.split('.').first, function_id: all_funtions[f[2].to_s.split('.').first]&.id, efective_id: all_employees[f[3].to_s.split('.').first]&.id, department_id: all_departments[f[4].to_s.split('.').first]&.id, position_id: all_positions[f[5].to_s.split('.').first]&.id) if f[0].present?}.compact || []
      when 'users'
        self.users = data.map {|f| nomes = f.first.to_s.split(' '); User.new(first_name: nomes.shift, last_name: nomes.pop, middle_name: nomes.join(' '), email: f[1].to_s.gsub('mailto:', '').gsub('recibo@bancosol.ao', ''), employee_id: all_employees[f[2].to_s.split('.').first.to_s]&.id) if f[0].present?}.compact || []
    end
    data
  end
end
