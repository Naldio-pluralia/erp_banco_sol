class QuestionOption < ApplicationRecord
  belongs_to :question
  has_one :course, through: :question
  validates_presence_of :question_id, :status, :option
  validates_uniqueness_of :option, scope: [:question_id]
  validates_uniqueness_of :status, scope: [:question_id], if: ->(o){o.question_id.present? && o.question&.single_choice? && o.correct?}

  enum status: {incorrect: 0, correct: 1}
end
