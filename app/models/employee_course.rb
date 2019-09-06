class EmployeeCourse < ApplicationRecord
  belongs_to :employee
  belongs_to :course
  has_many :employee_chapters, dependent: :destroy
  has_many :employee_exams, through: :employee_chapters
  has_many :employee_lessons, through: :employee_chapters
  has_many :employee_questions, through: :employee_exams
  has_many :employee_question_options, through: :employee_questions
  has_many :employee_answers, through: :employee_questions
  has_many :chapters, through: :course
  has_many :exams, through: :chapters
  has_many :lessons, through: :chapters
  has_many :questions, through: :exams
  has_many :question_options, through: :questions
  has_many :answers, through: :questions
  enum status: {in_progress: 0, done: 1}
  before_create :before_create_increment_attempt

  def self.approved
    where(is_approved: true)
  end

  def self.not_approved
    where(is_approved: false)
  end

  def before_create_increment_attempt
    self.attempt_number = EmployeeCourse
                                        .where(employee_id: employee_id, course_id: course_id)
                                        .order(attempt_number: :asc)
                                        .map(&:attempt_number)
                                        .last
                                        .defs_to(0) + 1
  end

  def less_than_a_day?
    ((updated_at.to_time - created_at.to_time)/1.day).round < 1
  end

  def more_than_a_day?
    !less_than_a_day? && !more_than_a_week?
  end

  def more_than_a_week?
    ((updated_at.to_time - created_at.to_time)/1.day).round >= 7
  end

  def start_course
    curso = course
    # p curso.lessons
    # p curso.exams
    # p curso.questions
    # p curso.question_options

    p chapters = EmployeeChapter.create(curso.chapters.map{|l| {employee_course_id: id, chapter_id: l.id}})
    p emp_chap = chapters.index_by(&:chapter_id)
    p EmployeeLesson.create(curso.lessons.map{|l| {employee_chapter_id: emp_chap[l.chapter_id]&.id, lesson_id: l.id}})
    p exam_map = EmployeeExam.create(curso.exams.map{|l| {employee_chapter_id: emp_chap[l.chapter_id]&.id, exam_id: l.id}})
    exam_map = exam_map.index_by(&:exam_id)
    p ques_map = EmployeeQuestion.create(curso.questions.map{|l| {employee_exam_id: exam_map[l.exam_id]&.id, question_id: l.id}})
    p ques_map = ques_map.index_by(&:question_id)
    p EmployeeAnswer.create(curso.questions.select{|f| f.boolean_question? || f.short_answer? }.map{|l| {employee_question_id: ques_map[l.id]&.id}})
    p EmployeeQuestionOption.create(curso.question_options.map{|l| {employee_question_id: ques_map[l.question_id]&.id, question_option_id: l.id}})
  end

  def update_conclusion_percentage
    _cp = calc_conclusion_percentage()
    update_columns(conclusion_percentage: _cp, is_approved: _cp >= course.approval_amount, value: calc_value())
  end

  def calc_conclusion_percentage
    p completed = employee_lessons.done.size + employee_exams.done.size
    p not_completed = employee_lessons.not_done.size + employee_exams.not_done.size
    p completed.percentage_in(completed + not_completed)
  end

  def calc_value
    _es = employee_questions.includes(:question, employee_question_options: [:question_option]).to_a
    total = _es.sum{|f| f.question.value}
    correct_value = _es.select{|f| !f.question.short_answer? }.sum{|f| f.employee_question_options.map{|g| (g.question_option.correct? && g.selected?) || (g.question_option.incorrect? && g.not_selected?) ? nil : false}.compact.uniq.last == false ? 0 : f.value }
    correct_value.percentage_in(total)
  end
end
