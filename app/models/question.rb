class Question < ApplicationRecord
  belongs_to :exam
  has_many :question_options, dependent: :destroy
  has_one :course, through: :exam
  before_validation :before_validation_set_value, if: :short_answer?
  validates_presence_of :exam_id, :number
  validates_uniqueness_of :number, scope: [:exam_id]
  validates_numericality_of :value, greater_than: 0, unless: :short_answer?

  enum kind: {single_choice: 0, multiple_choice: 1, boolean_question: 2, short_answer: 3}

  def before_validation_set_value
    self.value = 0
  end
end
