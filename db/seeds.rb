# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def create_info
  ["PHP", "JavaScript", "C C++ and C#", "Python", "Ruby", "Spin", "Sql", "Haskell", "Ada", "Visual Basic", "Java"].each do |languege|
    Goal.create(name: languege, goal_type: "skill", status: "draft", nature: "objective_base", unit: "contracts", target: 0.0, assessment_id: 1, description: nil, for_everyone: true)
  end

  ["EXPERIÊNCIA COM INTEGRAÇÃO DE SISTEMAS", "CONHECIMENTO EM TECNOLOGIAS EMERGENTES", "SABER ADAPTAR TECNOLOGIA AO NEGÓCIO", "NOÇÕES BÁSICAS DE NEGÓCIO", "TRABALHAR EM EQUIPE", "Conhecimento das funções empresariais básicas",
    "tecnologias emergentes da empresa"].each do |languege|
    Goal.create(name: languege, goal_type: "skill", status: "draft", nature: "numeric", unit: "clients", target: 10.0, assessment_id: 1, description: nil, for_everyone: true)
  end
end


Setting.create!(entity_name: 'Banco Sol', entity_logo: nil, entity_address: :none, framework_version: '0.0.1', rails_version: '5.1.4', ruby_version: '4.2.1')
Admin.create!(first_name: 'next', last_name: 'bss', email: 'nextbss@mail.com', password: '123456', password_confirmation: '123456')

puts "Settings and Admin account created"

comp = Setting.last || Setting.new
path = File.open("#{Rails.root}/app/assets/images/bancosol-logo.png")
comp.entity_logo = path
comp.save!

puts "Settings updated"

def script_nextgad

  Plugin.generate_side_menu(true)
  puts "Sidemenu created"

  dep1 = Department.create(name: "DEP Finanças")
  dep2 = Department.create(name: "DEP Avaliação", department_id: dep1.id)
  dep3 = Department.create(name: "DEP Recursos Humanos", department_id: dep1.id)
  puts "Departments created"

  fun1 = Function.create(name: "Vigilante")
  fun2 = Function.create(name: "Secretário Geral")
  fun3 = Function.create(name: "Secretário")
  puts "Functions created"


  
  e1 = Employee.create(paygrade: 2, level: "A", avatar: nil, first_name: "JM", last_name: "Corria", middle_name: "Cabanga", number: '12345')
  p e1.errors.messages
  e2 = Employee.create(paygrade: 1, level: "B", avatar: nil, first_name: "Agostinho", last_name: "Manuel", middle_name: "Capitão", number: '12344')
  p e2.errors.messages
  e3 = Employee.create(paygrade: 3, level: "C", avatar: nil, first_name: "Ilton", last_name: "Flora", middle_name: "Ingui", number: '12343')
  p e3.errors.messages
  e4 = Employee.create(paygrade: 2, level: "D", avatar: nil, first_name: "Ana", last_name: "Laudália", middle_name: "Cabanga", number: '12342')
  p e4.errors.messages
  e5 = Employee.create(paygrade: 1, level: "B", avatar: nil, first_name: "Rita", last_name: "Lauriano", middle_name: "Lauriano", number: '12341')
  p e5.errors.messages
  e6 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Adario", last_name: "Manuel", middle_name: "Muatelembe", number: '12340')
  p e6.errors.messages
  e7 = Employee.create(paygrade: 3, level: "C", avatar: nil, first_name: "Ana", last_name: "Maria", middle_name: "Costa", number: '12339')
  p e7.errors.messages
  e8 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Adelina", last_name: "Augosto", middle_name: "Muhongo", number: '12338')
  p e8.errors.messages
  e9 = Employee.create(paygrade: 3, level: "A", avatar: nil, first_name: "Carlos", last_name: "de Almeida", middle_name: "Junior", number: '12337')
  p e9.errors.messages
  e10 = Employee.create(paygrade: 3, level: "C", avatar: nil, first_name: "Alexandro", last_name: "Caíco", middle_name: "Camila", number: '12336')
  p e10.errors.messages
  e11 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Carmelita", last_name: "Dagmar", middle_name: "Dalida", number: '12335')
  p e11.errors.messages
  e12 = Employee.create(paygrade: 3, level: "A", avatar: nil, first_name: "Alírio", last_name: "Capitolina", middle_name: "António", number: '12334')
  p e12.errors.messages
  e13 = Employee.create(paygrade: 3, level: "C", avatar: nil, first_name: "Carmelina", last_name: "Carmelinda", middle_name: "Dagoberto", number: '12333')
  p e13.errors.messages
  e14 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Canto", last_name: "Carina", middle_name: "Damião", number: '12332')
  p e14.errors.messages
  e15 = Employee.create(paygrade: 3, level: "A", avatar: nil, first_name: "Aléxia", last_name: "Carissa", middle_name: "Daina", number: '12331')
  p e15.errors.messages
  e16 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Alícia", last_name: "Daliana", middle_name: "Daniela", number: '12330')
  p e16.errors.messages
  e17 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Gabínia", last_name: "Eder", middle_name: "Edina", number: '12329')
  p e17.errors.messages
  e18 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Gabínio", last_name: "Daliana", middle_name: "Daniela", number: '12328')
  p e18.errors.messages
  e19 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Gabino", last_name: "Daliana", middle_name: "Daniela", number: '12327')
  p e19.errors.messages
  e20 = Employee.create(paygrade: 3, level: "D", avatar: nil, first_name: "Gabriel", last_name: "Daliana", middle_name: "Gardela", number: '12326')
  p e20.errors.messages
  data = (1..2000).map{|f| {paygrade: 3, level: "D", avatar: nil, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.first_name, number: f} }
  Employee.create(data)
  employees = Employee.all
  employees.each do |e|
    e.avatar = File.open("#{Rails.root}/app/assets/images/user.png")
    e.save!
  end
  puts "Employees created"

  p1 = Position.create(name: "CEO", position_id: nil,   department_id: dep1.id, function_id: fun1.id, efective_id: e1.id)
  p2 = Position.create(name: "Finanças", position_id: p1.id, department_id: dep2.id, function_id: fun2.id, efective_id: e2.id)
  p3 = Position.create(name: "Comercio", position_id: p1.id, department_id: dep3.id, function_id: fun3.id, efective_id: e3.id)
  p4 = Position.create(name: Faker::Job.field, position_id: p2.id, department_id: dep3.id, function_id: fun3.id, efective_id: e4.id)
  p5 = Position.create(name: Faker::Job.field, position_id: p2.id, department_id: dep3.id, function_id: fun3.id, efective_id: e5.id)
  p6 = Position.create(name: Faker::Job.field, position_id: p3.id, department_id: dep3.id, function_id: fun3.id, efective_id: e6.id)
  p7 = Position.create(name: Faker::Job.field, position_id: p2.id, department_id: dep3.id, function_id: fun3.id, efective_id: e7.id)
  p8 = Position.create(name: Faker::Job.field, position_id: p4.id, department_id: dep3.id, function_id: fun3.id, efective_id: e8.id)
  p9 = Position.create(name: Faker::Job.field, position_id: p6.id, department_id: dep3.id, function_id: fun3.id, efective_id: e9.id)
  p10 = Position.create(name: Faker::Job.field, position_id: p4.id, department_id: dep3.id, function_id: fun3.id, efective_id: e10.id)
  p11 = Position.create(name: Faker::Job.field, position_id: p7.id, department_id: dep3.id, function_id: fun3.id, efective_id: e11.id)
  p12 = Position.create(name: Faker::Job.field, position_id: p2.id, department_id: dep3.id, function_id: fun3.id, efective_id: e12.id)
  p13 = Position.create(name: Faker::Job.field, position_id: p5.id, department_id: dep3.id, function_id: fun3.id, efective_id: e13.id)
  p14 = Position.create(name: Faker::Job.field, position_id: p12.id, department_id: dep2.id, function_id: fun3.id, efective_id: e14.id)
  p15 = Position.create(name: Faker::Job.field, position_id: p9.id, department_id: dep3.id, function_id: fun3.id, efective_id: e15.id)
  p16 = Position.create(name: Faker::Job.field, position_id: p8.id, department_id: dep2.id, function_id: fun3.id, efective_id: e16.id)
  p17 = Position.create(name: Faker::Job.field, position_id: p9.id, department_id: dep3.id, function_id: fun3.id, efective_id: e17.id)
  p18 = Position.create(name: Faker::Job.field, position_id: p3.id, department_id: dep3.id, function_id: fun3.id, efective_id: e18.id)
  p19 = Position.create(name: Faker::Job.field, position_id: p2.id, department_id: dep3.id, function_id: fun3.id, efective_id: e19.id)
  p20 = Position.create(name: Faker::Job.field, position_id: p1.id, department_id: dep3.id, function_id: fun3.id, efective_id: e20.id)
  puts "Positions created"

  ass1 = Assessment.create(status: "active", year: 2017, skills_percentage: 20, objectives_percentage: 40, attendance_percentage: 40)
  puts "Assessment created"

  goal1 = Goal.create(name: "Dinamca Individual", goal_type: "skill", status: "draft", nature: "numeric", unit: "contracts", target: 20.0, assessment_id: ass1.id)
  puts "Goals created"

  
  empl_goal31 = EmployeeGoal.create(self_assessment: 5, supervisor_assessment: 4, final_assessment: 4, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e1.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 60, name: "Dinamca Individual",       position_id: p1.id, amount: 0)
  p empl_goal31.errors.messages
  empl_goal32 = EmployeeGoal.create(self_assessment: 0, supervisor_assessment: 0, final_assessment: 4, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e1.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 60, name: "Dinamca de Grupo",         position_id: p1.id, amount: 0)
  p empl_goal32.errors.messages
  empl_goal33 = EmployeeGoal.create(self_assessment: 4, supervisor_assessment: 3, final_assessment: 5, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e1.id,unit: "contracts", goal_type: "skill", nature: "numeric", target: 60, name: "Competencias Informaticas", position_id: p1.id, amount: 0)
  p empl_goal33.errors.messages
  empl_goal34 = EmployeeGoal.create(self_assessment: 3, supervisor_assessment: 0, final_assessment: 2, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e1.id, unit: "clients",   goal_type: "objective", nature: "objective_base", target: 50.0, name: "Aumentar numero de clientes", position_id: p1.id)
p empl_goal34.errors.messages
  
  empl_goal21 = EmployeeGoal.create(self_assessment: 4, supervisor_assessment: 0, final_assessment: 3, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e2.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 40, name: "Dinamca Individual",       position_id: p2.id, amount: 0)
  p empl_goal21.errors.messages
  empl_goal22 = EmployeeGoal.create(self_assessment: 3, supervisor_assessment: 3, final_assessment: 3, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e2.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 40, name: "Dinamca de Grupo",         position_id: p2.id, amount: 0)
  p empl_goal22.errors.messages
  empl_goal23 = EmployeeGoal.create(self_assessment: 0, supervisor_assessment: 0, final_assessment: 2, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e2.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 40, name: "Competencias Informaticas", position_id: p2.id, amount: 0)
  p empl_goal23.errors.messages
  empl_goal24 = EmployeeGoal.create(self_assessment: 0, supervisor_assessment: 0, final_assessment: 5, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e2.id, unit: "clients",   goal_type: "objective", nature: "objective_base", target: 50.0, name: "Aumentar numero de clientes", position_id: p2.id)
p empl_goal24.errors.messages
  
  empl_goal11 = EmployeeGoal.create(self_assessment: 3, supervisor_assessment: 0, final_assessment: 2, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e3.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 20.0, name: "Dinamca Individual", position_id: p3.id, amount: 0)
  p empl_goal11.errors.messages
  empl_goal12 = EmployeeGoal.create(self_assessment: 4, supervisor_assessment: 3, final_assessment: 4, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e3.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 20.0, name: "Dinamca de Grupo", position_id: p3.id, amount: 0)
  p empl_goal12.errors.messages
  empl_goal13 = EmployeeGoal.create(self_assessment: 5, supervisor_assessment: 0, final_assessment: 4, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e3.id, unit: "contracts", goal_type: "skill", nature: "numeric", target: 20.0, name: "Competencias Informaticas", position_id: p3.id, amount: 0)
  p empl_goal13.errors.messages
  empl_goal14 = EmployeeGoal.create(self_assessment: 3, supervisor_assessment: 0, final_assessment: 2, status: "draft", assessment_id: ass1.id, goal_id: goal1.id, employee_id: e3.id, unit: "clients",   goal_type: "objective", nature: "objective_base", target: 50.0, name: "Aumentar numero de clientes", position_id: p3.id)
  p empl_goal14.errors.messages
  puts "Employee Goals created"

  
  user1 = User.create(first_name: e1.first_name, last_name: e1.last_name, email: "jm@bancosol.ao", employee_id: e1.id, password: '123456', password_confirmation: '123456', employee_number: e1.number)
  p user1.errors.messages
  user2 = User.create(first_name: e2.first_name, last_name: e2.last_name, email: "agostinho@bancosol.ao",      employee_id: e2.id, password: '123456', password_confirmation: '123456', employee_number: e2.number)
  p user2.errors.messages
  user3 = User.create(first_name: e3.first_name, last_name: e3.last_name, email: "ilton@bancosol.ao",     employee_id: e3.id, password: '123456', password_confirmation: '123456', employee_number: e3.number)
  p user3.errors.messages
  user4 = User.create(first_name: e4.first_name, last_name: e4.last_name, email: "ana@bancosol.ao",       employee_id: e4.id, password: '123456', password_confirmation: '123456', employee_number: e4.number)
  p user4.errors.messages
  user5 = User.create(first_name: e5.first_name, last_name: e5.last_name, email: "rita@bancosol.ao",      employee_id: e5.id, password: '123456', password_confirmation: '123456', employee_number: e5.number)
  p user5.errors.messages
  user6 = User.create(first_name: e6.first_name, last_name: e6.last_name, email: "adario@bancosol.ao",    employee_id: e6.id, password: '123456', password_confirmation: '123456', employee_number: e6.number)
  p user6.errors.messages
  puts "Users created"
end


script_nextgad
