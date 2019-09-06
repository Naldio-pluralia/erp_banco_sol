class GoalsRecord < ApplicationRecord
  self.abstract_class = true

  attr_accessor :who_belongs

  enum who_belongs: {all_goals: 0, function: 1, position: 2, general: 3 }
  enum mode: {numeric: 0, objective_base: 1 }
  enum period: {all_year: 0, first_quarter: 31, second_quarter: 32, third_quarter: 33, fourth_quarter: 34, first_semester: 61, second_semester: 62 }

  # criação de objectivos individuais
  def create_individual_goals
    employee_ids = []
    # pegando os ids dos coladorador na posição, funcão, coladorador como tal (employee)
    employee_ids << self&.positions.map{|e| [e&.efective&.id]}
    employee_ids << self&.functions.map{|e| [e&.positions.map{|i| [i&.efective&.id]}]}
    employee_ids << self&.employees&.ids
    # criação dos objectivos individuais
    employee_ids&.flatten&.uniq&.compact.each do |id|
      IndividualGoal.create(
        employee_id:      id,
        individual_value: 0.0,
        supervisor_value: 0.0,
        pca_value:        0.0,
        pertence_type:    self.class.name,
        pertence_id:      self.id
      )
    end
    
  end

end
