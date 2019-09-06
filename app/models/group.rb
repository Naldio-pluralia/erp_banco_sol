class Group < ApplicationRecord

  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :group_id
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :group_id
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :group_id

  validates_presence_of :group_type, :status
  #validates_uniqueness_of :name, scope: [:directorate_id]

  enum group_type: {t_delay: 0, t_exit: 1, t_vacation: 2, t_absence: 3, t_presence: 4}
  enum status: {active: 0, inactive: 1}

end
