class FunctionSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :function
  validates_presence_of :skill_id, :function_id, :min, :recomended
  validates_uniqueness_of :skill_id, scope: [:function_id]
  validates_numericality_of :min, less_than: :recomended, greater_than_or_equal_to: 0, if: ->(s){s.min.present? && s.recomended.present?}
  validates_numericality_of :recomended, less_than_or_equal_to: 10
end
