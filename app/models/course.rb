class Course < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :employee_courses, dependent: :destroy
  has_many :lessons, through: :chapters
  has_many :exams, through: :chapters
  has_many :questions, through: :exams
  has_many :question_options, through: :questions
  has_many :course_obligated_functions, dependent: :destroy
  has_many :course_optional_functions, dependent: :destroy
  has_many :obligated_functions, through: :course_obligated_functions, source: :function
  has_many :optional_functions, through: :course_optional_functions, source: :function
  validates_presence_of :name, :approval_amount
  validates_numericality_of :approval_amount, greater_than_or_equal_to: 0
  before_save :before_save_fix_conflict
  enum status: {draft: 0, closed: 1, opened: 2}

  def self.accessible_to(employee)
    if employee.nil?
      none
    else
      all
    end
  end

  def build_employees
    CourseObligatedFunction.create(Function.all.map{|f| {function_id: f.id, course_id: id}})
    CourseOptionalFunction.create(Function.all.map{|f| {function_id: f.id, course_id: id}})
  end

  def before_save_fix_conflict
    self.optional_function_ids -= obligated_function_ids
  end
end
